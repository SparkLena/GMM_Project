
%dirname='LM_ExmpDg_pws9x9_noise0729', ni=2;
%dirname='LM_ExmpDg_pws13x13_noise2187',ni=3;
dirname='LM_ExmpDg_pws21x21_noise6561', ni=4;

sig_noise_v=[0.0003]*3.^[4:7];

maxgrid=21;

for j=1:maxgrid
   
      d=dir(sprintf('testFitMOGresb_ws%02d_ind%02d.mat',j,ni-1));
  
    
    if (length(d))
        eval(['load ',d(1).name])
        if (length(err9)>=(ni-1))
            merr_epll(j-2)=err9(ni-1);
            merr_ctr(j-2)=err1(ni-1);
            merr_avg(j-2)=err6(ni-1);
            
        end
    
    end
    
end
%mL=length(merr_avg)

eval(sprintf('load %s/evalRespp',dirname)) 
load covLM/avgres

f=figure, hold on
cf=get(f,'Children') 
set(cf,'FontSize',20)
ii1=[1:length(er)]+2;
ii3=[1:length(merr_avg)]+2;
er1=max(er1,v1)
%all_er1=max(all_er1,all_v1)
all_v1=min(all_er1,all_v1)

%plot(ii1,-10*log10(er1),'Color',[1,0.4,0],'LineWidth',3,'Marker','o','MarkerFaceColor',[1,0.4,0],'MarkerSize',5)

%plot(ii1,-10*log10(v1),'r','LineWidth',3,'Marker','o','MarkerFaceColor','r','MarkerSize',5)

plot(ii1,-10*log10(all_er1),'Color',[1,0.4,0],'LineWidth',3,'Marker','o','MarkerFaceColor',[1,0.4,0],'MarkerSize',5)

plot(ii1,-10*log10(all_v1),'r','LineWidth',3,'Marker','o','MarkerFaceColor','r','MarkerSize',5)


ii2=[size(aerr,2):-1:1]*2+1;
plot(ii2,-10*log10(aerr(ni,:)),'b','LineWidth',3,'Marker','o','MarkerFaceColor','b','MarkerSize',5)

plot(ii3,-10*log10(merr_ctr),'Color',[0.5,0,1],'LineWidth',3,'Marker','o','MarkerFaceColor',[0.5,0,1],'MarkerSize',5)
plot(ii3,-10*log10(merr_avg),'Color',[0,1,0.5],'LineWidth',3,'Marker','o','MarkerFaceColor',[0,1,0.5],'MarkerSize',5)
plot(ii3,-10*log10(merr_epll),'Color',[1,0.5,0.5],'LineWidth',3,'Marker','o','MarkerFaceColor',[1,0.5,0.5],'MarkerSize',5)


load BM3D/testBM3DLMbits4res
plot(4,-10*log10(merr(ni)),'dg','MarkerFaceColor','g','MarkerSize',15)
BM3Des(1)=-10*log10(merr(ni));
%load  KSVD/test_KSVDgen_res.mat
load  KSVD/test_KSVDgenadbits_res_mini1_maxi2000
if (ni==4)
    load KSVD/test_KSVDgenadbitsHn_res_mini1_maxi2000
end
if (ni==2)
   plot(maxgrid-2.5,-10*log10(merr(ni)),'^m','MarkerFaceColor','m','MarkerSize',15)
else
    plot(maxgrid-2,-10*log10(merr(ni)),'^m','MarkerFaceColor','m','MarkerSize',15)
end

ksvdpsnr=-10*log10(merr(ni))

%load  portilla_denoise/test_portilla_res.mat
load  test_portilla_bits_res.mat
portpsnr=-10*log10(merr(ni))

plot(maxgrid-2,-10*log10(merr(ni)),'sc','MarkerFaceColor','c','MarkerSize',15)
%keyboard

minv=min(-10*log10(aerr(ni,:)))
%maxv=max(-10*log10(er))
maxv=max(-10*log10(all_v1))

if (ni==3)
  axis([0 maxgrid minv*0.99, maxv*1.49])
end
if (ni==2)
    axis([0 maxgrid minv*0.99, maxv*1.37])
end
if (ni==4)
    axis([0 maxgrid minv*0.94, maxv*1.6])
end
h=legend('MMSE^U','MMSE^L','LMMSE','MOG ctr','MOG avg','MOG EPLL','BM3D','KSVD','GSM')
set(h,'FontSize',17)

xlabel('Support size k','FontSize',20')
ylabel('PSNR','FontSize',20')

if 0
d1=+10*log10(er1)-10*log10(er1-er1_std')
d2=-10*log10(er1)+10*log10(er1+er1_std')
errorbar(ii1,-10*log10(er1), d1,d2 ,'Color',[1,0.4,0],'LineWidth',3)

d1=+10*log10(v1)-10*log10(v1-v1_std')
d2=-10*log10(v1)+10*log10(v1+v1_std')
errorbar(ii1,-10*log10(v1), d1,d2 ,'Color',[1,0,0],'LineWidth',3)
end

%load  KSVD/test_KSVDgen_res.mat
%plot(8,10*log10(merr(ni)),'^m','MarkerFaceColor','m','MarkerSize',20)

%load  portilla_denoise/test_portilla_res.mat
%plot(max(ii2),10*log10(merr(ni)),'sc','MarkerFaceColor','c','MarkerSize',20)


%load BM3D/testBM3DLM4res.mat
%plot(4,10*log10(merr(ni)),'vg','MarkerFaceColor','g','MarkerSize',20)



%plot(ii1,10*log10(er1),'r.')
%plot(ii2,10*log10(aerr(ni,:)),'b.')
%plot(ii1,10*log10(er),'r.')


%load BM3D/testBM3DLMres.mat
load BM3D/testBM3DLMbits8res
plot(8,-10*log10(merr(ni)),'dg','MarkerFaceColor','g','MarkerSize',15)
BM3Des(2)=-10*log10(merr(ni));
if (ni>2)
  %load BM3D/testBM3DLMhnres.mat
  load BM3D/testBM3DLMbits12res
  plot(12,-10*log10(merr(ni)),'dg','MarkerFaceColor','g','MarkerSize',15)
  BM3Des(3)=-10*log10(merr(ni));
else
  load BM3D/testBM3DLMbits12res.mat
  plot(12,-10*log10(merr(ni)),'dg','MarkerFaceColor','g','MarkerSize',15)  
  BM3Des(3)=-10*log10(merr(ni));
end


eval(sprintf('print -depsc MOGerrcomp_noise%s.eps',dirname(end-3:end)))

if (length(all_er1)>10)
  mmseuerr=-10*log10(all_er1([2,6,10]))
  [mmseuerr;BM3Des;mmseuerr-BM3Des]
else
  mmseuerr=-10*log10(all_er1([2,6]))  
  [mmseuerr(1:2);BM3Des(1:2);mmseuerr(1:2)-BM3Des(1:2)]
end
ksvdpsnr

%ni 2, gap at 4,8,  0.0216    -0.3564
%ni 3, gap at 4,8,12 0.8516    0.0956    0.0858
%ni 4, gap at 4,8,12 3.8378    0.5223    0.0027
%%%%%%%%%%%%%%%

%ni 3, gap at 4,8,12   0.9428    0.3515    0.6526
%ni 2, gap at 4,8,     0.0490    0.2372
%ni 4, gap at 4,8,12   3.5520    0.6407   -0.0357


%ni=3, gap at k=8 is 0.7DB
%ni=3, gap at k=12 is [0.3-1.15]DB
%ni=2, gap at k=8 is [0.28-2.0]DB
%ni=2, gap at k=4 is 0.59DB

 
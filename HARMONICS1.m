clc
clear all

Nof=1000; %Number of Frames
sr=44100;
tpf=1;
fm = 50; %signal
MI = 230*sqrt(2); %modulation index
mh=20; %Maximum harmonic order
tsnd=linspace(0,tpf,int32(tpf*sr));

writeobj = VideoWriter('harmo','Uncompressed AVI');
writeobj.FrameRate=1;
open(writeobj);

fig1=figure('Renderer', 'painters', 'Position', [280 80 900 600]);

a1=[];
s1=[];
for i=1:2:mh
    v1=m((4/pi)*MI*(1/i),i*fm,tsnd);
    a1=[a1;v1];
    %s=[s v1]
    s1=[s1 (int16(v1)*32767)];
end
filename = 'handel.wav';
audiowrite(filename,s1,sr);

t=linspace(0,0.02,Nof);
V = m(MI,fm,t);

a=[];
%s=[];
for i=1:2:mh
    v1=m((4/pi)*MI*(1/i),i*fm,t);
    a=[a;v1];
    %s=[s v1]
    %s=[s (int16(v1)*32767)];
end


[r,c]=size(a);

b=zeros(1,1000);

sub1=subplot(2,1,1);
title('Fundamental with Harmonics')
subtitle('Developed By Dr.M.Kaliamoorthy')
h = gca;
set(h,'XLim',[0 0.02], 'Ylim',[-2*230*sqrt(2) 2*230*sqrt(2)], 'Color','k');
h.XAxis.Visible = 'off';
h.YAxis.Visible = 'on';
ani1=animatedline('LineWidth',2,'Color',"r");
subplot(2,1,2)
h1 = gca;
set(h1,'XLim',[0 0.02], 'Ylim',[-2*230*sqrt(2) 2*230*sqrt(2)], 'Color','k');
h1.XAxis.Visible = 'on';
h1.YAxis.Visible = 'on';
for k=1:r
    v(k)=animatedline('LineWidth',2,'Color',[randi(100)/100 randi(100)/100 randi(100)/100]);
end
ani2=animatedline('LineWidth',2,'Color',"r");
videoFWriter = vision.VideoFileWriter('AudioInputPort', true)
j1=1:2:mh;

for j=1:r
    title_str=strcat("From Fundamental Component to  ", num2str(j1(j)), " Harmonics");  
    clearpoints(ani1)
    b=b+a(j,:);

    addpoints(ani1,t,b);
    title(title_str)
    addpoints(v(j),t,a(j,:));
    drawnow
    sound(b,8000)
    currFrame=getframe(fig1);
    writeVideo(writeobj, currFrame)
    
    
end

close(writeobj)

function e= m(MI,f,t) %modulation function1
  e=(MI*sin(2*pi*f*t));  
end
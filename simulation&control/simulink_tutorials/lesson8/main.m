%���õ�ǰm�ļ�����·��Ϊ����Ŀ¼
clear all;
local_address=mfilename('fullpath');
%�趨�������
Ra=0.2;
La=0.014;
Rf=183.333;
Laf=2.4;
C=0.4;
U=220;
T0=16.055;
%��Simulink�����ļ�
open_system('DC_Machine.slx');
open_system('Weak_magnetic.slx');
set_param('DC_Machine/Speed regulating resistance','Resistance','1e-7');
set_param('DC_Machine/U 220V','Amplitude','220');

%��ʼ����
sim('DC_Machine');
%ȡ9-17s��������
Te=T(900:1700,2);
n=n(900:1700,2);
Ia=Ia(900:1700,2);
T2=Te-T0;
%��е����
plot_initialize('T_e/(N\bulletm)','n/rpm','Mechanical characteristic curve of dc motor');
plot(Te,n,'LineWidth',1.5,'color','r');
%��������
w=n*2*pi/60;
P2=T2.*w;
P1=U*Ia;
Eta=P2./P1;
plot_initialize('P_2/W','n/rpm','Speed characteristics curve of dc motor');
plot(P2,n,'LineWidth',1.5,'color','r');%ת������
plot_initialize('P_2/W','T_e/(N\bulletm)','Torque characteristics curve of dc motor');
plot(P2,Te,'LineWidth',1.5,'color','r');%ת������
plot_initialize('P_2/W','\eta','Efficiency characteristics curve of dc motor');
plot(P2,Eta,'LineWidth',1.5,'color','r');%Ч������

%���������
Te1=Te;
n1=n;
set_param('DC_Machine/Speed regulating resistance','Resistance','0.5');
sim('DC_Machine');
Te2=T(900:1700,2);
n2=n(900:1700,2);
set_param('DC_Machine/Speed regulating resistance','Resistance','1');
sim('DC_Machine');
Te3=T(900:1700,2);
n3=n(900:1700,2);
plot_initialize('T_e/(N\bulletm)','n/rpm','Armature series resistance speed adjustment');
hold on
plot(Te1,n1,'LineWidth',1.5,'color','b');
plot(Te2,n2,'LineWidth',1.5,'color','r')
plot(Te3,n3,'LineWidth',1.5,'color','g')
legend({'0\Omega','0.5\Omega','1\Omega'});

%��ѹ����
Te4=Te1;
n4=n1;
set_param('DC_Machine/Speed regulating resistance','Resistance','1e-7');
set_param('DC_Machine/U 220V','Amplitude','210');
sim('DC_Machine');
Te5=T(900:1700,2);
n5=n(900:1700,2);
set_param('DC_Machine/U 220V','Amplitude','200');
sim('DC_Machine');
Te6=T(900:1700,2);
n6=n(900:1700,2);
set_param('DC_Machine/U 220V','Amplitude','190');
sim('DC_Machine');
Te7=T(900:1700,2);
n7=n(900:1700,2);
plot_initialize('T_e/(N\bulletm)','n/rpm','Voltage drop speed regulation');
hold on
plot(Te4,n4,'LineWidth',1.5,'color','b');
plot(Te5,n5,'LineWidth',1.5,'color','r');
plot(Te6,n6,'LineWidth',1.5,'color','g');
plot(Te7,n7,'LineWidth',1.5,'color','c');
legend({'220V','210V','200V','190V'});
set_param('DC_Machine/U 220V','Amplitude','220');
sim('DC_Machine');

%���ŵ���
sim('Weak_magnetic');
%ȡ20.5-29.5s������
n=n(2050:2950,2);
If=lf(2050:2950,2);
plot_initialize('I_f/A','n/rpm','Weak magnetic speed regulation');
plot(If,n,'LineWidth',1.5,'color','r');

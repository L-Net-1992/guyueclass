#include<reg52.h>
#include "LPF.h"
#include "LPF_private.h"
#define uint unsigned int
#define uchar unsigned char
#define y P2
uint volt; 
uchar addr;
sbit CLK=P1^7;//����ʱ���źſ�
sbit DIN=P1^6;//����2543����д���
sbit DOUT=P1^5;//����2543���ݶ�ȡ��
sbit CS=P1^4;//����2543Ƭѡ�źſ�
sbit P2_5=P2^5;

void read2543(uchar addr)
{
	uint ad=0;
	uchar i;
	CLK=0;
	CS=0;//Ƭѡ�Σ�����2543
	addr<<=4;//�Ե�ַλԤ����
	for(i=0;i<12;i++) //12��ʱ�����꣬���һ�ζ�ȡ����
	{
		if(DOUT==1)
			ad=ad|0x01;//��Ƭ����ȡad����
		DIN=addr&0x80;//2543��ȡ������ַλ
		CLK=1;
		;;;//�̵ܶ���ʱ
		CLK=0;//�����½��أ�����ʱ���ź�
		;;;
		addr<<=1;
		ad<<=1;//��������λ׼����һλ�Ķ�д
	}
	CS=1;//��2543
	ad>>=1;
	volt=ad;//ȡ��ת�����
	}

void main()
{
	addr=0;
	LPF_initialize();
	TMOD=0x01;
	TH0=0xD8;
	TL0=0xF0;
	TR0=1;
	EA=1;
	ET0=1;
	while(1)
	{
		read2543(addr);
	}
}
void Timer0_ISR(void) interrupt 1
{
	TH0=0xD8;
	TL0=0xF0;
	LPF_U.In1=volt;
	LPF_step();
	y=LPF_Y.Out1/16;
	
}
#include "exti.h"
#include "delay.h"
#include "usart.h"
//////////////////////////////////////////////////////////////////////////////////	 
//������ֻ��ѧϰʹ�ã�δ��������ɣ��������������κ���;
//Mini STM32������
//�ⲿ�ж� ��������			   
//����ԭ��@ALIENTEK
//������̳:www.openedv.com
//�޸�����:2010/12/01  
//�汾��V1.0
//��Ȩ���У�����ؾ���
//Copyright(C) ����ԭ�� 2009-2019
//All rights reserved	  
////////////////////////////////////////////////////////////////////////////////// 	  
 
 
//�ⲿ�жϳ�ʼ������

volatile unsigned int Motor_Count=0;

void Exit_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;                //�ṹ��
	EXTI_InitTypeDef EXTI_InitStructure;							 	//����EXTI�ṹ��	
	NVIC_InitTypeDef NVIC_InitStructure;						 	  //����NVIC�ṹ��	
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA|RCC_APB2Periph_AFIO ,ENABLE);
													  //����GPIOA�͸��ù��ܵ�ʱ��
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1;           //ѡ��1~4������
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;   //io���ٶ�
	GPIO_InitStructure.GPIO_Mode =GPIO_Mode_IPU;        //����Ϊ��������ģʽ
	GPIO_Init(GPIOA, &GPIO_InitStructure);              //��ʼ��PA1

	GPIO_EXTILineConfig(GPIO_PortSourceGPIOA, GPIO_PinSource1);
																										  //���ö˿�Ϊ�ж�ģʽ

	EXTI_InitStructure.EXTI_Line = EXTI_Line1;       
																										  //ѡ����·
	EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt; //���� EXTI ��·Ϊ�ж�����
	EXTI_InitStructure.EXTI_Trigger =EXTI_Trigger_Rising;//�����ؽ��ش���
	EXTI_InitStructure.EXTI_LineCmd = ENABLE;        
				//��������ѡ����·����״̬�������Ա���Ϊ ENABLE ���� DISABLE������ENABLE��
	EXTI_Init(&EXTI_InitStructure);                    //��ʼ���ⲿ�ж�

	NVIC_InitStructure.NVIC_IRQChannel = EXTI1_IRQn;         //ѡ��ͨ��
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;//�����ȼ�
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;       //�����ȼ�
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;          //����ʹ�ܻ���ʧ��ָ�����ж�ͨ��
	NVIC_Init(&NVIC_InitStructure);														//��ʼ��NVIC�жϿ�����	
}

void EXTI1_IRQHandler(void)
{
	if(EXTI_GetITStatus (EXTI_Line1)==1)
	{
		Motor_Count++;
		EXTI_ClearITPendingBit(EXTI_Line1);
	}
}

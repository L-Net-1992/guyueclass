#include "tim.h"


void TIM4_Init(u16 arr,u16 psc)        							  //TIM3 ��ʼ�� arr��װ��ֵ pscԤ��Ƶϵ��
{
  	TIM_TimeBaseInitTypeDef     TIM_TimeBaseInitStrue;//����TIM�ṹ��
    
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM4,ENABLE);//ʹ��TIM3
    TIM4_NVIC_Init (); 																 //����TIM3�ж�����
	      
    TIM_TimeBaseInitStrue.TIM_Period=arr; 												//�����Զ���װ��ֵ
    TIM_TimeBaseInitStrue.TIM_Prescaler=psc; 											//Ԥ��Ƶϵ��
    TIM_TimeBaseInitStrue.TIM_CounterMode=TIM_CounterMode_Up; 		//�������������
    TIM_TimeBaseInitStrue.TIM_ClockDivision=TIM_CKD_DIV1; 				//ʱ�ӵķ�Ƶ���ӣ�����һ������ʱ���ã�һ����ΪTIM_CKD_DIV1
    TIM_TimeBaseInit(TIM4,&TIM_TimeBaseInitStrue); 								//TIM3��ʼ������
    TIM_ITConfig(TIM4, TIM_IT_Update, ENABLE);										//�����ж����ͣ�ʹ��TIM3�ж�    
    TIM_Cmd(TIM4,ENABLE);																				  //���ö�ʱ���ж����ȼ���ʹ��TIM3
}

void TIM4_NVIC_Init (void)                                       //����TIM3�ж�����
{
	NVIC_InitTypeDef NVIC_InitStructure;
	NVIC_InitStructure.NVIC_IRQChannel = TIM4_IRQn;	
	NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0x3;	   //������ռ�������ȼ�
	NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0x3;
	NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
  	NVIC_Init(&NVIC_InitStructure);
}

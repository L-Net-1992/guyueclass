#include "motor.h"

void Motor_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStruct;
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB,ENABLE);//����ʱ��
	GPIO_InitStruct.GPIO_Mode=GPIO_Mode_Out_PP;
	GPIO_InitStruct.GPIO_Pin=GPIO_Pin_8 |GPIO_Pin_9 ;
	GPIO_InitStruct.GPIO_Speed=GPIO_Speed_50MHz;
	GPIO_Init(GPIOB,&GPIO_InitStruct);	
	PBout(8)=1;
	PBout(9)=0;
}

int motor_abs(int p) //����pwmֻ��������   ������Ҫȡ����ֵ
{
	int q;
	q=p>0?p:(-p);
	return q;
}

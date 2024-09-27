//ALIENTEK miniSTM32������ʵ��1
//�����ʵ��  
//����֧�֣�www.openedv.com
//������������ӿƼ����޹�˾
#include "delay.h"
#include "sys.h"

/*
int main(void)
{	
	��ʱ��ʼ��	
	�жϳ�ʼ��
	OLED��ʼ��
	PWM��ʼ��
	��ʱ����ʼ��
	�����ʼ��
	while(1)
	{	
		OLED��ʾ����
	}
}

*/
int pwm=0;		
int count;     //oled��ʾ�ٶ�
int aim_speed=50;
char oledBuf[20];
int main(void)
{	
	delay_init();	    	 //��ʱ������ʼ��	
	Exit_Init();			//�жϺ�����ʼ��
	
	OLED_Init();
	OLED_ColorTurn(0);//0������ʾ��1 ��ɫ��ʾ
	OLED_DisplayTurn(0);//0������ʾ 1 ��Ļ��ת��ʾ
	OLED_Clear();
	
	TIM3_PWM_Config_Init(0,9999);	
	TIM4_Init(500,7199);//50ms
	Motor_Init();
	while(1)
	{	
		sprintf(oledBuf," Motor_Control");
		OLED_ShowString(0,0,(u8*)oledBuf,16);//��һ����ʾ	
		sprintf(oledBuf,"Aim_Speed:%3d",aim_speed);
		OLED_ShowString(0,16,(u8*)oledBuf,16);//�ڶ�����ʾ
		sprintf(oledBuf,"Act_Speed:%3d",count);
		OLED_ShowString(0,32,(u8*)oledBuf,16);//��������ʾ
		sprintf(oledBuf,"Pwm_data;%5d",pwm); 
		OLED_ShowString(0,48,(u8*)oledBuf,16);//��������ʾ
		OLED_Refresh();  //��Ļˢ��
	}
}
void TIM4_IRQHandler(void)														//TIM4�жϴ�����
{ 	 
    if (TIM_GetITStatus(TIM4, TIM_IT_Update) == 1)		//�ж��Ƿ���TIM4�ж�
	{	
		TIM_ClearITPendingBit(TIM4, TIM_IT_Update);     //����жϱ�־λ
		pwm=PID_control(Motor_Count,aim_speed);
		/*��ȡ�������ɼ��������������õ�������ٶ�*/
		count=Motor_Count;
		TIM3_SetPWM_Num(motor_abs(pwm),1);
		Motor_Count=0;
		
    }
}

#define HSE_VALUE ((uint32_t)8000000) /* STM32 discovery uses a 8Mhz external crystal */

#include "stm32f4xx_conf.h"
#include "stm32f4xx.h"
#include "stm32f4xx_gpio.h"
#include "stm32f4xx_rcc.h"
#include "stm32f4xx_exti.h"
#include "usbd_cdc_core.h"
#include "usbd_usr.h"
#include "usbd_desc.h"
#include "usbd_cdc_vcp.h"
#include "usb_dcd_int.h"

volatile uint32_t ticker, downTicker;

/*
 * The USB data must be 4 byte aligned if DMA is enabled. This macro handles
 * the alignment, if necessary (it's actually magic, but don't tell anyone).
 */
__ALIGN_BEGIN USB_OTG_CORE_HANDLE  USB_OTG_dev __ALIGN_END;


void init();
void ColorfulRingOfDeath(void);

/*
 * Define prototypes for interrupt handlers here. The conditional "extern"
 * ensures the weak declarations from startup_stm32f4xx.c are overridden.
 */
#ifdef __cplusplus
 extern "C" {
#endif

void SysTick_Handler(void);
void NMI_Handler(void);
void HardFault_Handler(void);
void MemManage_Handler(void);
void BusFault_Handler(void);
void UsageFault_Handler(void);
void SVC_Handler(void);
void DebugMon_Handler(void);
void PendSV_Handler(void);
void OTG_FS_IRQHandler(void);
void OTG_FS_WKUP_IRQHandler(void);

#ifdef __cplusplus
}
#endif

#define BIT_SET(bitset, bit)                ((bitset) |= (1 << (bit)))
#define BIT_CLEAR(bitset, bit)              ((bitset) &= ~(1 << (bit)))
#define BIT_IS_SET(bitset, bit)             ((bitset) & (1 << (bit)))

int main(void)
{
	/* Set up the system clocks */
	SystemInit();

	/* Initialize USB, IO, SysTick, and all those other things you do in the morning */
	init();


	while (1)
	{
		/* Blink the orange LED at 1Hz */
		if (500 == ticker)
		{
			GPIOD->BSRRH = GPIO_Pin_13;
		}
		else if (1000 == ticker)
		{
			ticker = 0;
			GPIOD->BSRRL = GPIO_Pin_13;
		}

		uint8_t theByte;
		uint16_t Word;
		if (VCP_get_char(&theByte))
		{

			switch (theByte)
			{
				case '?':
					VCP_send_str("INEJ");
				break;

				case 'W':
					VCP_get_char(&theByte);
					Word = theByte << 8;
					VCP_get_char(&theByte);
					Word += theByte;
					GPIO_Write(GPIOB, Word);
					break;

				case 'R':
					Word = GPIO_ReadInputData(GPIOE);
					VCP_put_char(Word);
					VCP_put_char(Word >> 8);
					break;

				case 'C':
					VCP_get_char(&theByte);
					if ( BIT_IS_SET(theByte, 3) != 0 ) {
						BIT_CLEAR(theByte, 3);
						GPIO_SetBits(GPIOC, (1 << theByte));
					} else {
						GPIO_ResetBits(GPIOC, (1 << theByte) );
					}
					break;

				case 'T':
					theByte = GPIO_ReadInputDataBit(GPIOC, GPIO_Pin_5);
					VCP_put_char(theByte);
					break;
			}


			GPIOD->BSRRL = GPIO_Pin_12;
			downTicker = 10;
		}
		if (0 == downTicker)
		{
			GPIOD->BSRRH = GPIO_Pin_12;
		}
	}

	return 0;
}


void init()
{
	/* STM32F4 discovery LEDs */
	GPIO_InitTypeDef LED_Config;

	/* Always remember to turn on the peripheral clock...  If not, you may be up till 3am debugging... */
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOD, ENABLE);
	LED_Config.GPIO_Pin = GPIO_Pin_12 | GPIO_Pin_13| GPIO_Pin_14| GPIO_Pin_15;
	LED_Config.GPIO_Mode = GPIO_Mode_OUT;
	LED_Config.GPIO_OType = GPIO_OType_PP;
	LED_Config.GPIO_Speed = GPIO_Speed_25MHz;
	LED_Config.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init(GPIOD, &LED_Config);

	/* Вывод Данных в ТЕСТЕР */
	GPIO_InitTypeDef GPIOB_Config;
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOB, ENABLE);
	GPIOB_Config.GPIO_Pin = GPIO_Pin_All;
	GPIOB_Config.GPIO_Mode = GPIO_Mode_OUT;
	GPIOB_Config.GPIO_OType = GPIO_OType_PP;
	GPIOB_Config.GPIO_Speed = GPIO_Speed_25MHz;
	GPIOB_Config.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init(GPIOB, &GPIOB_Config);

	/* Ввод Данных в ЭВМ */
	GPIO_InitTypeDef GPIOE_Config;
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOE, ENABLE);
	GPIOE_Config.GPIO_Pin = GPIO_Pin_All;
	GPIOE_Config.GPIO_Mode = GPIO_Mode_IN;
	GPIOE_Config.GPIO_OType = GPIO_OType_PP;
	GPIOE_Config.GPIO_Speed = GPIO_Speed_25MHz;
	GPIOE_Config.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init(GPIOE, &GPIOE_Config);

	/* Шина Управления */
	GPIO_InitTypeDef GPIOC_Config;
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);
	GPIOC_Config.GPIO_Pin = GPIO_Pin_1 | GPIO_Pin_2| GPIO_Pin_3| GPIO_Pin_4;
	GPIOC_Config.GPIO_Mode = GPIO_Mode_OUT;
	GPIOC_Config.GPIO_OType = GPIO_OType_PP;
	GPIOC_Config.GPIO_Speed = GPIO_Speed_25MHz;
	GPIOC_Config.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init(GPIOC, &GPIOC_Config);

	GPIOC_Config.GPIO_Pin = GPIO_Pin_5;
	GPIOC_Config.GPIO_Mode = GPIO_Mode_IN;
	GPIOC_Config.GPIO_OType = GPIO_OType_PP;
	GPIOC_Config.GPIO_Speed = GPIO_Speed_25MHz;
	GPIOC_Config.GPIO_PuPd = GPIO_PuPd_NOPULL;
	GPIO_Init(GPIOC, &GPIOC_Config);


	/* Setup SysTick or CROD! */
	if (SysTick_Config(SystemCoreClock / 1000))
	{
		ColorfulRingOfDeath();
	}


	/* Setup USB */
	USBD_Init(&USB_OTG_dev,
	            USB_OTG_FS_CORE_ID,
	            &USR_desc,
	            &USBD_CDC_cb,
	            &USR_cb);

	return;
}

/*
 * Call this to indicate a failure.  Blinks the STM32F4 discovery LEDs
 * in sequence.  At 168Mhz, the blinking will be very fast - about 5 Hz.
 * Keep that in mind when debugging, knowing the clock speed might help
 * with debugging.
 */
void ColorfulRingOfDeath(void)
{
	uint16_t ring = 1;
	while (1)
	{
		uint32_t count = 0;
		while (count++ < 500000);

		GPIOD->BSRRH = (ring << 12);
		ring = ring << 1;
		if (ring >= 1<<4)
		{
			ring = 1;
		}
		GPIOD->BSRRL = (ring << 12);
	}
}

/*
 * Interrupt Handlers
 */

void SysTick_Handler(void)
{
	ticker++;
	if (downTicker > 0)
	{
		downTicker--;
	}
}

void NMI_Handler(void)       {}
void HardFault_Handler(void) { ColorfulRingOfDeath(); }
void MemManage_Handler(void) { ColorfulRingOfDeath(); }
void BusFault_Handler(void)  { ColorfulRingOfDeath(); }
void UsageFault_Handler(void){ ColorfulRingOfDeath(); }
void SVC_Handler(void)       {}
void DebugMon_Handler(void)  {}
void PendSV_Handler(void)    {}

void OTG_FS_IRQHandler(void)
{
  USBD_OTG_ISR_Handler (&USB_OTG_dev);
}

void OTG_FS_WKUP_IRQHandler(void)
{
  if(USB_OTG_dev.cfg.low_power)
  {
    *(uint32_t *)(0xE000ED10) &= 0xFFFFFFF9 ;
    SystemInit();
    USB_OTG_UngateClock(&USB_OTG_dev);
  }
  EXTI_ClearITPendingBit(EXTI_Line18);
}

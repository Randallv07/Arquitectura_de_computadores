/**
 * Raspberry Pi Pico - Voltmeter
 * Sends via i2c
 * Works with ADC pin 0
 * See: www.penguintutor.com/projects/pico
 */


#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include <stdio.h>

//Dirección del I2C
#define I2C_ADDR 0x3E

int main() {
    stdio_init_all();
    // Inicia el I2C 
    i2c_init(i2c0, 10000);
    //Configura la pico como master
    i2c_set_slave_mode(i2c0, false, I2C_ADDR);
    //Configura los pines correspondientes como I2C
    gpio_set_function(4, GPIO_FUNC_I2C);
    gpio_set_function(5, GPIO_FUNC_I2C);
    gpio_pull_up(4);
    gpio_pull_up(5);


    //Dato que se va a enviar
    char Palabra[] = "hola";
    uint8_t value;

    //Espera 20s antes que empiece el loop
    sleep_ms(20000);
    while (true) {
        //Obtiene e imprime la cantidad de bytes disponibles en el canal para escribir
        int bytes=i2c_get_write_available(i2c0);
        printf("Cantidad de Bytes: %d \n",bytes);
        //Ciclo para enviar cada carácter del mensaje
        for (int i=0; i<4;i++)
        {
            //Asigna a value el carácter correspondiente
            value=Palabra[i];
            //Verifica si se puede escrbir, en caso de que no, continua el ciclo
            if (i2c_get_write_available(i2c0) == 0) continue;
            //Escribe el carácter de value
            i2c_write_blocking(i2c0, 0x3E,&value, 1, true);
            //Imprime el carácter escrito
            printf ("Send Data:%d\r\n", value);
        }
    
        
    }
}


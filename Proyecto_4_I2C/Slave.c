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
    //Configura la pico como esclavo
    i2c_set_slave_mode(i2c0, true, I2C_ADDR);
    //Configura los pines correspondientes como I2C
    gpio_set_function(4, GPIO_FUNC_I2C);
    gpio_set_function(5, GPIO_FUNC_I2C);
    gpio_pull_up(4);
    gpio_pull_up(5);

    //Variable donde se almacena el dato leido
    uint8_t  rxdata;
    //Espera 20s antes que empiece el loop
    sleep_ms(20000);
    while (true) {
        //Verifica si hay bytes en el canal para leer, en caso de que no, continua al siguiente ciclo
        if (i2c_get_read_available(i2c0) < 1) 
        {
            continue;
        }    
        printf("Se encontró mensaje\n");
        //Lectura del mensaje 
        i2c_read_raw_blocking (i2c0, &rxdata, 1);
        //Muestra el mensaje en terminal
        printf ("Value %d\r\n", rxdata);
    }
}


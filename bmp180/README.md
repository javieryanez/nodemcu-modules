# BMP180 module

## Load module

bmp180 = require("bmp180")

## Functions
### init
init(sda, scl)  
Initialize module. Initializacion is mandatory before read values.

**Parameters:**

* sda - SDA pin  
* scl - SCL pin

### read
read(oss)  
Read temperature and pressure from BMP180.

**Parameters:**  
* oss - oversampling setting. 0: ultra low power, 1: standard, 2: high resolution,3: ultra high resolution.

###getTemperature
getTemperature()  
Returns the temperature of the last temperature reading.

**Returns:**  
* last temperature reading in 0.1ºC

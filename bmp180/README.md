# BMP180 module

## Load module

bmp180 = require("bmp180")

## Functions
### init
init(sda, scl)  
Initialize module. Initializacion is mandatory before read values.

**Parameters:**

* sda - SDA pin  
* sca - SCL pin

### read
read(oss)  
Read temperature and pressure from BMP180.

**Parameters:**  
* oss - oversampling setting. 0: ultra low power, 1: standard, 2: high resolutuion,3: ultra high resolution.

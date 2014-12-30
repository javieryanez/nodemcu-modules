# BMP180 module

## Example  
```lua
OSS = 1 -- oversampling setting (0-3)
SDA_PIN = 9 -- sda pin, GPIO2
SCL_PIN = 8 -- scl pin, GPIO0

bmp180 = require("bmp180")
bmp180.init(SDA_PIN, SCL_PIN)
bmp180.read(OSS)
t = bmp180.getTemperature()
p = bmp180.getPressure()

-- temperature in degrees Celsius  and Farenheit
print("Temperature: "..(t/10).."."..(t%10).." deg C")
print("Temperature: "..(9 * t / 50 + 32).."."..(9 * t / 5 % 10).." deg F")

-- pressure in differents units
print("Pressure: "..(p).." Pa")
print("Pressure: "..(p / 100).."."..(p % 100).." hPa")
print("Pressure: "..(p / 100).."."..(p % 100).." mbar")
print("Pressure: "..(p * 75 / 10000).."."..((p * 75 % 10000) / 1000).." mmHg")

-- release module
bmp180 = nil
package.loaded["bmp180"]=nil
```
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

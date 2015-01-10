-- ***************************************************************************
-- DHT22 module for ESP8266 with nodeMCU
--
-- Written by Javier Yanez 
-- but based on a script of Pigs Fly from ESP8266.com forum
--
-- MIT license, http://opensource.org/licenses/MIT
-- ***************************************************************************

local moduleName = ...
local M = {}
_G[moduleName] = M

local humidity = 0
local temperature = 0
local checksum = 0
local checksumTest = 0

local function tryRead(pin)
  bitStream = {}
  for j = 1, 40, 1 do
    bitStream[j] = 0
  end
  bitlength = 0

  gpio.mode(pin, gpio.OUTPUT)
  gpio.write(pin, gpio.LOW)
  tmr.delay(20000)
  -- Use Markus Gritsch trick to speed up read/write on GPIO
  gpio_read = gpio.read
  gpio_write = gpio.write

  gpio.mode(pin, gpio.INPUT)

  -- bus will always let up eventually, don't bother with timeout
  while (gpio_read(pin) == 0 ) do end

  c=0
  while (gpio_read(pin) == 1 and c < 100) do c = c + 1 end

  -- bus will always let up eventually, don't bother with timeout
  while (gpio_read(pin) == 0 ) do end

  c=0
  while (gpio_read(pin) == 1 and c < 100) do c = c + 1 end

  -- acquisition loop
  for j = 1, 40, 1 do
    while (gpio_read(pin) == 1 and bitlength < 10 ) do
      bitlength = bitlength + 1
    end
    bitStream[j] = bitlength
    bitlength = 0
    -- bus will always let up eventually, don't bother with timeout
    while (gpio_read(pin) == 0) do end
  end

  --DHT data acquired, process.
  for i = 1, 16, 1 do
    if (bitStream[i + 0] > 2) then
      humidity = humidity + 2 ^ (16 - i)
    end
  end
  for i = 1, 16, 1 do
    if (bitStream[i + 16] > 2) then
      temperature = temperature + 2 ^ (16 - i)
    end
  end
  for i = 1, 8, 1 do
    if (bitStream[i + 32] > 2) then
      checksum = checksum + 2 ^ (8 - i)
    end
  end

  checksumTest=((humidity / 256) + (humidity % 256) + (temperature / 256) + (temperature % 256)) % 256
end

function M.read(pin)
  attempts = 0
  checksumTest = -1
  while attempts < 3 and checksum ~= checksumTest do
     tryRead(pin)
     attempts = attempts + 1
  end
  if attempts > 3 then
    humidity = 0
    temperature = 0
  end
end

function M.getTemperature()
  return temperature
end

function M.getHumidity()
  return humidity
end

return M

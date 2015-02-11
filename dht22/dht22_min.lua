local e=...local a={}_G[e]=a
local o
local d
function a.read(e)local r
local t
o=0
d=0
r=0
local i=gpio.read
local l={}for e=1,40,1 do
l[e]=0
end
local a=0
gpio.mode(e,gpio.OUTPUT)gpio.write(e,gpio.HIGH)tmr.delay(100)gpio.write(e,gpio.LOW)tmr.delay(2e4)gpio.write(e,gpio.HIGH)gpio.mode(e,gpio.INPUT)while(i(e)==0)do end
local n=0
while(i(e)==1 and n<500)do n=n+1 end
while(i(e)==0)do end
n=0
while(i(e)==1 and n<500)do n=n+1 end
for d=1,40,1 do
while(i(e)==1 and a<10)do
a=a+1
end
l[d]=a
a=0
while(i(e)==0)do end
end
for e=1,16,1 do
if(l[e]>4)then
o=o+2^(16-e)end
end
for e=1,16,1 do
if(l[e+16]>4)then
d=d+2^(16-e)end
end
for e=1,8,1 do
if(l[e+32]>4)then
r=r+2^(8-e)end
end
t=(bit.band(o,255)+bit.rshift(o,8)+bit.band(d,255)+bit.rshift(d,8))t=bit.band(t,255)if d>32768 then
d=-(d-32768)end
if(t-r>=1)or(r-t>=1)then
o=nil
end
end
function a.getTemperature()return d
end
function a.getHumidity()return o
end
return a

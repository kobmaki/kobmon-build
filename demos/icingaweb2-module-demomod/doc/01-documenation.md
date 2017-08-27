# DemoMod 

DemoMod is a demonstration module. It constructs a demo environment that is based on the Icinga2 configuration language.
It uses some addidtion icingaweb modules like

* [icingaweb2-module-nagvis](https://github.com/icinga/icingaweb2-module-nagvis) for [NagVis](http://nagvis.org/) integration.
* [icingaweb2-module-map](https://github.com/nbuchwitz/icingaweb2-module-map)
* [icingaweb2-module-cube](https://github.com/icinga/icingaweb2-module-cube) 

When using the demo, it creates in icinga2 round about 230 addition Host objects and 1000 Service objects. It creates host dependency by parent host. The host objects have some addition Information, like dependency, geolocation for map.

## What it is?
A simple demo! Maybe good for education.

## What it is not!
Not a real monitoring. It is just demo mod!

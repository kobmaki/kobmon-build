# DemoMod

DemoMod is a demonstration module. It constructs a demo environment that is based on the Icinga2 configuration language.
It uses some additional icingaweb modules like

* [icingaweb2-module-nagvis](https://github.com/icinga/icingaweb2-module-nagvis) for [NagVis](http://nagvis.org/) integration.
* [icingaweb2-module-map](https://github.com/nbuchwitz/icingaweb2-module-map)
* [icingaweb2-module-cube](https://github.com/icinga/icingaweb2-module-cube)

When using the demo, it creates in icinga2 round about 230 addition Host objects and 1000 Service objects. It creates host dependency by parent host. The host objects have some addition Information, like dependency, geolocation for map.

## What it is?
A simple demo! Maybe good for education.

## What it is not!
Not a real monitoring. It is just demo mod!

## Screenshots
Some screenshots with the enabled demomod.

### Tactical overview
![Tactical  overview](images/Tactical_overview-DEMOMOD-Mixed.png)

### Hostgroup
![hostgroups overview, CRITICAL states](images/Hostgroups-Overview-DEMOMOD-Critical.png)

### Module map if available
If you have the module map enabled:

![MAP overview, OK states](images/Host_Map_OSM-OK.png)

![MAP overiew, MIX states](images/Host_Map_OSM-Critical-with-info.png)

### Module cube if available

![Cube data from](images/Cube-demomod-data_from.png)

![Cube data from and data typeof](images/Cube-data_from-data_typeof.png)
### Module nagvis if avaible
With the dependency in the nodes you get nice views.

![NagView for math type](images/NagVis-Type-Math-Critical.png)

### Module businessprocess if availabble
TODO

### Module toplevelview if available
TODO

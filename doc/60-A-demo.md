# DemoMod ([back](00-A-documentation.md))
Is a icinga2 configuration and a icingaweb2 module. It creates hosts an services from the icinga2 language.

The DemoMod creates around:
* 280 hosts
* 1500 services
* 63 hostgroups
* 36 servicegroups
* 560 dependencies

The hosts and services change there state dynamic in an interval of 15 minutes.

The create host objects are enriched with geo coordinate for other module like statusmap, map. Also the host object have defined variable to define cubes.

# Installation of DemoMod
Look at the [documentation inside the icingaweb2 module demomod](../demos/icingaweb2-module-demomod/doc/01-documenation.md) for further documentation.

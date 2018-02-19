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
You have already checkout this repo.

* Add the **DEMODMOD.conf** to icinga2.conf.
* Add the **icingaweb2-module-demomod**  to icingaweb2 module path
* Restart icinga2 to enable the **DEMODMOD.conf**

You have checkout the repo to /usr/local/kobmon-build/  like:
```
  git clone https://github.com/kobmaki/kobmon-build/ /usr/local/kobmon-build
  ```

Add the following line to the end of your icinga2.conf
```
include "/usr/local/kobmon-build/conf/icinga2/demo.d/DEMOMOD.conf"
```

Link the icingaweb2-module-demomod to the icingaweb2-module dir.

```
ln -s /usr/local/kobmon-build/demos/icingaweb2-module-demomod /usr/share/icingaweb2/modules/demomod
```

Restart your icinga2 daemon.
Enable in the icingaweb2 the module demomod.

Sit back and enjoy watching your monitoring instance!!!

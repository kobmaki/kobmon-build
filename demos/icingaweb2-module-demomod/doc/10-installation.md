# Installation of demomod

The following installation description use the default installation paths.

##  Clone the kobmon-build repo

You start with a clone of the kobmon-build repo from github. 

```
  git clone https://github.com/kobmaki/kobmon-build 
```

The module demomod is in demos/icingaweb2-module-demomod. You have to link it by

```
  cd kobmon-build 
  ln -s $(pwd)/demos/icingaweb2-module-demomod /usr/share/icingaweb2/modules/demomod
```

## More Repos to clone

To use everything from the demo you have to clone more repos.

```  
  cd /usr/share/icingaweb2/modules
  git clone https://github.com/nbuchwitz/icingaweb2-module-map map
  git clone https://github.com/icinga/icingaweb2-module-nagvis nagvis
  git clone https://github.com/icinga/icingaweb2-module-cube cube
```

## Enable the modules in icingaweb2
Use eighter the webfrontend to enable the modules or run on commandline the following commands
```
 icingacli module enable demomod
 icingacli module enable cube
 icingacli module enable map
 icingacli module enable nagvis
```

## Use the nagvis maps
When nagvis is installed, you should copy the predefined maps DEMOMOD to /etc/nagvis/maps/

```
  cp demos/nagvis-demomod/maps/DEMOMAP*.cfg /etc/nagvis/maps/
```

## Add the DEMOMOD.cfg for icinga2
Test if your icinga2 is working:
``` 
  icinga2 daemon -C
```
If it is fine you can add the kobmon-build/conf/icinga2/demo.d/DEMOMOD.conf to your /etc/icinga2/icinga2.conf
```
 include "/HERE/THE/PATH/TO/kobmon-build/conf/icinga2/demo.d/DEMOMOD.conf"
```

Using a softlink into your icinga2/conf.d/ doesn't work, sorry.

And test again
```
  icinga2 daemon -C
```

Now restart/reload your icinga2.



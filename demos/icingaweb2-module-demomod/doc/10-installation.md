# Installation of demomod

The following installtion try to use the default installation paths.

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
 icingacli module enable demomap
 icingacli module enable cube
 icingacli module enable map
 icingacli module enable nagvis
```

## Use the nagvis maps
When nagvis is installed, you should copy the predefined maps DEMOMOD to /etc/nagvis/maps/

```
  cp demos/nagvis-demomod/maps/DEMOMAP*.cfg /etc/nagvis/maps/
```



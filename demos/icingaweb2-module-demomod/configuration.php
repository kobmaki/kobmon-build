<?php
/**
* Contains menu configuration for
* module 'DemoMod'
*/

$this->provideConfigTab('config', array(
    'title' => $this->translate('Configure this module'),
    'label' => $this->translate('Config'),
    'url' => 'config'
));

$section = $this->menuSection('DemoMod',
    array(
    'title' => 'DemoMod',
    'icon' => 'menu',
    'priority' => 200
           )
    );

$section->add('Help', array(
    'url' => 'doc/module/toc?moduleName=demomod',
    'icon' => 'book',
    'priority' => 99
));

$section->add('Hostgroup', array (
    'url' => 'monitoring/list/hostgroups?hostgroup_name=DEMOMOD*&sort=hosts_total&dir=desc',
    'icon'=> 'menu',
    'title' => 'Hostgroups starting with DemoMod',
    'label' => 'Hostgroups',
    'priority' => 20
   ));


$section->add('Hosts', array (
    'url' => 'monitoring/list/hosts?_host_demomod=DEMOMOD',
    'icon'=> 'menu',
    'title' => 'Hosts created by DemoMod',
    'label' => 'Hosts',
    'priority' => 20
   ));

#
$section->add('Servicegroups', array (
    'url' => 'monitoring/list/servicegroups?servicegroup_name=DEMOMOD-%2A&sort=services_total&dir=desc',
    'icon'=> 'menu',
    'title' => 'Servicegroups created by DemoMod',
    'label' => 'Servicegroups',
    'priority' => 20
   ));

$section->add('Cube - Types', array (
    'url' => 'cube?dimensions=demomod,data_typeof',
    'icon'=> 'cubes',
    'title' => 'DemoMod Cube Types',
    'priority' => 60
   )); 

$section->add('Cube - Source - Types', array (
    'url' => 'cube?dimensions=demomod,data_from,data_typeof',
    'icon'=> 'cubes',
    'title' => 'DemoMod Cube Types and subtype',
    'priority' => 60
   ));

$section->add('Host map (OSM)', array (
    'url' => 'map?default_zoom=2&default_lat=52.520645&default_long=13.409779',
    'icon'=> 'cubes',
    'title' => 'Map from OpenstreetMap',
    'priority' => 30
   ));


/**
 * Create entries from a list
 */
foreach ( array('System','Math','globals','Type','Object','ConfigObject','CustomVarObject','Logger','CheckCommand') as $value) {

$section->add('Type - '.$value.' (NagVis)', array (
    'url' => 'nagvis/show/map?map=DEMOMOD'.$value,
    'icon'=> 'cubes',
    'title' => 'NagVis automap starting with node '.$value,
    'priority' => 80
   ));

}



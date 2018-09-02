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
    'title' => 'Demo Module',
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
    'url' => 'monitoring/list/hostgroups?hostgroup_name=DEMOMOD*&sort=hosts_total&dir=desc&limit=500',
    'icon'=> 'menu',
    'title' => 'Hostgroups starting with DemoMod',
    'label' => 'Hostgroups',
    'priority' => 20
   ));


$section->add('Hosts', array (
    'url' => 'monitoring/list/hosts?_host_demomod=DEMOMOD&limit=500',
    'icon'=> 'menu',
    'title' => 'Hosts created by DemoMod',
    'label' => 'Hosts',
    'priority' => 10
   ));

$section->add('Services', array (
    'url' => 'monitoring/list/services?_host_demomod=DEMOMOD&limit=100&dir=desc',
    'icon'=> 'menu',
    'title' => 'Services created by DemoMod',
    'label' => 'Services',
    'priority' => 10
   ));


#
$section->add('Servicegroups', array (
    'url' => 'monitoring/list/servicegroups?servicegroup_name=DEMOMOD-%2A&sort=services_total&dir=desc&limit=500',
    'icon'=> 'menu',
    'title' => 'Servicegroups created by DemoMod',
    'label' => 'Servicegroups',
    'priority' => 20
   ));

/**
  * Add entries if module cube is enabled
  *
  */

if ($this->exists("cube")) {
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

    $section->add('Cube - Host parent path', array (
    'url' => 'cube?dimensions=host_parent_path',
    'icon'=> 'cubes',
    'title' => 'DemoMod Cube host parent path',
    'priority' => 80
    ));
}

/**
 * Add entry if the map module exists
 * /
if ( $this->exists("map") ) {
    $section->add('Host map (OSM)', array (
        'url' => 'map?default_zoom=2&default_lat=22.7559&default_long=42.0117',
        'icon'=> 'cubes',
        'title' => 'Map from OpenstreetMap',
        'priority' => 30
       ));
}



/**
 * Create entries from a list if nagvis module exist
 */

if ($this->exists("nagvis")) {
    foreach (array('System','Math','globals','Type','Object'
                   ,'ConfigObject','CustomVarObject','Logger','CheckCommand') as $value) {
        $section->add('Type - '.$value.' (NagVis)', array (
        'url' => 'nagvis/show/map?map=DEMOMOD'.$value,
        'icon'=> 'cubes',
        'title' => 'NagVis automap starting with node '.$value,
        'priority' => 80
        ));
    }
}

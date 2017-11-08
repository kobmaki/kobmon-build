<?php
/**
* Contains menu configuration for
* module '@@TEMPLATE@@'
*
* If required you can add you javascript code and additional CSS files.
*
*/

// Add your additional javascript libraries. These file(s) will be included in the icinga.min.js
// that is create dynamicly.
//
// $this->provideJsFile('vendor/@@TEMPLATE@@.js');

// Add some stylesheets
// $this->provideCssFile('vendor/@@TEMPLATE@@.css');

$this->provideConfigTab('config', array(
    'title' => $this->translate('Configure this module'),
    'label' => $this->translate('Config'),
    'url' => 'config'
));

$section = $this->menuSection('@@Template@@',
    array(
    'title' => '@@TEMPLATE@@',
    'icon' => 'menu',
    'priority' => 200
           )
    );

$section->add('@@Template@@ index', array(
    'url' => '@@TEMPLATE@@/index/index',
    'title' => '@@TEMPLATE@@ (index)',
    'icon' => 'menu',
    'priority' => 80
    ));

$section->add('@@Template@@ details', array(
    'url' => '@@TEMPLATE@@/index/details',
    'icon' => 'menu',
    'priority' => 90
    ));

$section->add('Help', array(
    'url' => 'doc/module/toc?moduleName=@@TEMPLATE@@',
    'icon' => 'book',
    'priority' => 99
    ));

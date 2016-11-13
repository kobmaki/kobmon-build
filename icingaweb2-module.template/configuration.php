<?php
/**
* Contains menu configuration for
* module '@@TEMPLATE@@'
*/

$this->provideConfigTab('config', array(
    'title' => $this->translate('Configure this module'),
    'label' => $this->translate('Config'),
    'url' => 'config'
));

$section = $this->menuSection('@@TEMPLATE@@',
    array(
    'title' => '@@TEMPLATE@@',
    'icon' => 'menu',
    'priority' => 200
           )
    );

$section->add('Help', array(
    'url' => 'doc/module/toc?moduleName=@@TEMPLATE@@',
    'icon' => 'book',
    'priority' => 99
    ));

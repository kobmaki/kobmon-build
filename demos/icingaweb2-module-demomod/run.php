<?php
/**
* run command. You should add here your hooks.
**/
use Icinga\Application\Icinga;

// remove comments if you provide some actions for Host or Service
// $this->provideHook('DemoMod/HostActions');
// $this->provideHook('DemoMod/ServiceActions');

// or if you have your own
// $this->provideHook('DemoMod/');;
$this->provideHook('monitoring/HostActions');

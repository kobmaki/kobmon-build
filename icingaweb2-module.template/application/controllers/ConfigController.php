<?php
/**
* File contains class ConfigController for
* Icinga\Module\@@TEMPLATE@@\Controllers.
*/

namespace Icinga\Module\@@TEMPLATE@@\Controllers;

use Icinga\Module\Monitoring\Controller;

/**
* Defines the ConfigController for modul '@@TEMPLATE@@'
*/
class ConfigController extends Controller
{
    /**
     * Display configuration for module @@TEMPLATE@@
     */
    public function indexAction()
    {
        $this->Config('config');
        $this->view->tabs = $this->Module()->getConfigTabs()->activate('config');
    }
}

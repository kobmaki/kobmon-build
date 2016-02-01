<?php

namespace Icinga\Module\@@TEMPLATE@@\Controllers;

use Icinga\Module\Monitoring\Controller;

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

?>
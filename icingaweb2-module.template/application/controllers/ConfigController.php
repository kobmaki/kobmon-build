<?php
/**
* File contains class ConfigController for
* Icinga\Module\@@Template@@\Controllers.
*/

namespace Icinga\Module\@@Template@@\Controllers;

use Icinga\Module\Web\Controller;

/**
* Defines the ConfigController for modul '@@TEMPLATE@@'
*/
class ConfigController extends Controller
{
    /**
    * Assert that permission config/modules is required
    */
    public function init()
    {
        $this->assertPermission('config/modules');
    }

    /**
     * Display configuration for module @@TEMPLATE@@
     */
    public function indexAction()
    {
        $this->Config('config');
        $this->view->tabs = $this->Module()->getConfigTabs()->activate('config');
    }
}

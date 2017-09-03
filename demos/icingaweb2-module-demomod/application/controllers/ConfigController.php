<?php
/**
* File contains class ConfigController for
* Icinga\Module\Demomod\Controllers.
*/

namespace Icinga\Module\Demomod\Controllers;

use Icinga\Module\Web\Controller;

/**
* Defines the ConfigController for modul 'demomod'
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
     * Display configuration for module demomod
     */
    public function indexAction()
    {
        $this->Config('config');
        $this->view->tabs = $this->Module()->getConfigTabs()->activate('config');
    }
}

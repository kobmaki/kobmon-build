<?php

namespace Icinga\Module\Demomod\ProvidedHook\Monitoring;

use Icinga\Web\Controller\ModuleActionController;
use Icinga\Module\Monitoring\Hook\HostActionsHook;
use Icinga\Module\Monitoring\Object\Host;
use Icinga\Web\Url;

class HostActions extends HostActionsHook
{
    public function getActionsForHost(Host $host)
    {
        return array(
            t("Icinga2 Docu") => Url::fromPath('https://github.com/Icinga/icinga2/blob/master/doc/18-library-reference.md', array('showHost' => $host->host_name))
        );
    }
}

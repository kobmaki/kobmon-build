<?php

namespace Icinga\Module\@@Template@@\Controllers;

use Icinga\Web\Controller\ModuleActionController;
use Icinga\Web\UrlParams;
use Icinga\Web\Widget\Tabextension\DashboardAction;

class IndexController extends ModuleActionController
{
    /** @var UrlParams */
    protected $params;

    public function indexAction()
    {
        $this->getTabs()->add('@@TEMPLATE@@', array(
            'label' => $this->translate('@@Template@@'),
            'url'   => $this->getRequest()->getUrl()
        ))->activate('@@TEMPLATE@@')->extend(new DashboardAction());

        $showSettings = $this->params->shift('showSettings');
        $format= $this->params->shift('format');

        $this->view->title = sprintf(
            $this->translate('@@Template@@: %s'),
            "@@Template@@ Title"
        );
    }

    public function detailsAction()
    {
        $this->getTabs()->add('details', array(
            'label' => $this->translate('@@Template@@ details'),
            'url'   => $this->getRequest()->getUrl()
        ))->activate('details');
 
        $this->view->title = "Detail title";
//        $this->view->links = ActionLinks::renderAll($@@TEMPLATE@@, $this->view);
    }
}

<?php
/**
* Contains info command for module @@TEMPLATE@@
**/

namespace Icinga\Module\@@TEMPLATE@@\Clicommands;

use Icinga\Cli\Command;
use Icinga\Application\Benchmark;

/**
* Class InfoCommand with default env command.
**/
class InfoCommand extends Command
{

/**
* Shows environment info.
*
* Usage
*
*   icingacli @@TEMPLATE@@ env [--benchmark]
**/
    public function envAction()
    {
        Benchmark::measure('Start env');
        print 'Environment for module '.$this->moduleName."\n";
        $aValue= getenv('ICINGAWEB_CONFIGDIR');
        print 'ICINGAWEB_CONFIGDIR='.$aValue."\n";
        print 'Modulepath for '.$this->moduleName;
        print ':'.realpath(__DIR__.DIRECTORY_SEPARATOR.'..'.DIRECTORY_SEPARATOR.'..')."\n";
        Benchmark::measure('Start env');
    }
}

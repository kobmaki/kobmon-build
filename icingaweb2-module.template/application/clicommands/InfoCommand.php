<?php
/**
* Contains info command for module @@TEMPLATE@@
**/

namespace Icinga\Module\@@TEMPLATE@@\Clicommands;

use Icinga\Cli\Command;
use Icinga\Application\Benchmark;

/**
* Class InfoCommand with date and env command.
*/
class InfoCommand extends Command
{

/**
* Shows environment info.
*
* Usage
*
*   icingacli @@TEMPLATE@@ info env [--benchmark]
*/
    public function envAction()
    {
        Benchmark::measure('Start env');
        print 'Environment for module '.$this->moduleName."\n";
        $aValue= getenv('ICINGAWEB_CONFIGDIR');
        print 'ICINGAWEB_CONFIGDIR='.$aValue."\n";
        print 'Modulepath for '.$this->moduleName;
        print ':'.realpath(__DIR__.DIRECTORY_SEPARATOR.'..'.DIRECTORY_SEPARATOR.'..')."\n";
        Benchmark::measure('End env');
    }

/**
* Show only the date
*
* Usage
*
*   icingacli @@TEMPLATE@@ info date [--benchmark]
*/
    public function dateAction()
    {
        Benchmark::measure('Start date');
        print date(DATE_RFC822)."\n";
        Benchmark::measure('End date');
    }
}

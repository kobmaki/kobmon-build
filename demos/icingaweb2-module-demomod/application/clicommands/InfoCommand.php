<?php
/**
* Contains info commands for module demomod
**/

namespace Icinga\Module\Demomod\Clicommands;

use Icinga\Cli\Command;
use Icinga\Cli\AnsiScreen;
use Icinga\Application\Benchmark;
use PDO;

/**
* Info command with date, env and driver actions.
*/
class InfoCommand extends Command
{

    protected $screen;

    public function init()
    {
        $this->app->setupZendAutoloader();
        $this->screen=new AnsiScreen();
    }
    /**
* Show environment information
*
* Usage
*
*   icingacli demomod info env [--benchmark]
*/
    public function envAction()
    {
        Benchmark::measure('Start env');
        print $this->screen->underline('Environment for module '.$this->moduleName."\n");
        $aValue= getenv('ICINGAWEB_CONFIGDIR');
        print 'ICINGAWEB_CONFIGDIR: '.$aValue."\n";
        print 'Modulepath for '.$this->moduleName;
        print ':'.realpath(__DIR__.DIRECTORY_SEPARATOR.'..'.DIRECTORY_SEPARATOR.'..')."\n";
        Benchmark::measure('End env');
    }

    /**
* Show only the date
*
* Usage
*
*   icingacli demomod info date [--benchmark]
*/
    public function dateAction()
    {
        Benchmark::measure('Start date');
        print date(DATE_RFC822)."\n";
        Benchmark::measure('End date');
    }

    /**
* Show the available pdo database driver
*
* Usage
*
*   icingacli demomod info driver [--benchmark]
*/
    public function driverAction()
    {
        Benchmark::measure('Start driver');
        print $this->screen->underline("driver for database \n");
        $countDriver=0;
        foreach (PDO::getAvailableDrivers() as $aDriver) {
            print "* ".$aDriver."\n";
            $countDriver+=1;
        };
        print $this->screen->underline('Total driver:'.$countDriver);
        print $this->screen->newlines();
        Benchmark::measure('End driver');
    }
}

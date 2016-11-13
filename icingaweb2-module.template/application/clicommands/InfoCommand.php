<?php
/**
* Contains info command for module @@TEMPLATE@@
**/

namespace Icinga\Module\@@TEMPLATE@@\Clicommands;

use Icinga\Cli\Command;

/**
* Class InfoCommand with default env command.
**/
class InfoCommand extends Command
{

/**
* Shows environment info.
* @return void
**/	
public function envAction() {
  print "Environment for module @@TEMPLATE@@\n";
  $aValue= getenv('ICINGAWEB_CONFIGDIR');
  print "ICINGAWEB_CONFIGDIR=".$aValue."\n";
  print 'Modulepath for @@TEMPLATE@@:'.realpath(__DIR__.DIRECTORY_SEPARATOR.'..'.DIRECTORY_SEPARATOR.'..')."\n";
}

}
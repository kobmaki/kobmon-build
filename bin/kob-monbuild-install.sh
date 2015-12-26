#!/bin/bash

# Author: Uwe Ebel
# Project: kobmon-build
# Version: 
# Licence: GPL
# Info: Build icinga/nagios environment


MYPWD=$(pwd) 
#

# some helper scripts

function decho (){
if [ "${DEBUG}" != "" ]; then
    echo $@
fi
}

function krc_status ()
{
    _krc_status_ret=$?
    case ${_krc_status_ret} in
    0) echo -n  "$(tput setaf 2 2>/dev/null)$1$(tput sgr0 2>/dev/null)"
            [[ -z $1 ]] ||  echo
    ;;
    1) echo -n  "$(tput setaf 1 2>/dev/null)$2$(tput sgr0 2>/dev/null)"
            [[  -z $2 ]] || echo
       ;;
    *)
            echo "UNKNOWN $_krc_status_ret "$3
      ;;
   esac
    return $_krc_status_ret
}


# read config file
. kob-monbuild-install.conf 2>/dev/null || ( echo "ERROR could not read kob-monbuild-install.conf" && exit 2 )


# all options with default value false 
# enable via optione -e OPTION
# -e nagios -e mediawiki
eBuildINFO=
eBuildNagios=
eBuildIcinga=
eBuildIcinga2=
eBuildCheckMK=
eFixDirLink=
eFixRights=
eBuildNdoutils=
eBuildIdoutils=
eBuildIdoDB=
eFixLibCopy=
eBuildMediawiki=
eBuildNagvis=
eShowFiles=
eShowHelp=
eBuildSnmptt=
eBuildNagtrap=

# nagiosbp
# ./configure  --prefix=/kob/nag/nagiosbp --with-naghtmurl=/nagios/ --with-htmurl=/nagios/nagiosbp/ --with-nagiosbp-user=nagios --with-nagiosbp-group=nagios --with-apache-user=nagios --with-httpd-conf=/kob/nag/nagiosbp/conf/apache/ --with-cron-d-dir=/kob/nag/nagiosbp/conf/cron.d

if [ $# -eq 0 ]; then
    eShowHelp=true
fi

# read options
while getopts "hixp:w:c:e:" Option
do
  case $Option in
    i) INFO=y
       eBuildINFO=y
      ;;
    p) 
          aPATH=${OPTARG};
          ;;
    w) aWarnPer=${OPTARG};
          ;;
    c) aCritPer=${OPTARG};
          ;;
    h) eShowHelp=true
	  
          ;;
    e) 	  case ${OPTARG} in
	      info) eInfo=true;;
	      nagios) eBuildNagios=true;;
              icinga) eBuildIcinga=true;;
	      icinga2) eBuildIcinga2=true;;
              mediawiki) eBuildMediawiki=true;;
              checkmk) eBuildCheckmk=true;; # not implemented
              livestatus) eBuildLivestatus=true;;
              nagvis)  eBuildNagvis=true ;;
              ndoutils) eBuildNdoutils=true ;;
              idoutils) eBuildIdoutils=true;;
              idodb) eBuildIdodb=true;;
              snmptt) eBuildSnmptt=true;;
              nagtrap) eBuildNagtrap=true;;
              showfiles) eShowFiles=true;;
              fixlibcopy) eFixLibCopy=true;;   
              fixdirlink) eFixDirLink=true;;
              
	      
	      *)
		  echo "ERROR option "${OPTARG}
		  ;;
	  esac
	  ;;
    x)
      aPathIsMount="Y"
      ;;
    *) CRITICAL=${CRITICAL}", UNSUPPORTER PARAMETER "${Option}
          ;;
      esac
done
#echo "FINISH"
# exit

# where is the source directory?
aSRCDIR=${aSRCDIR-$HOME/2install}

# we build it below of the source directory..
aBUILDDIR=${aSRCDIR}/build
# the owner of the file
aUSER=${aUSER-$(id -un)}
# and the groupd
aGROUP=${aGROUP-$(id -gn)}

mkdir ${aBUILDDIR} 2>/dev/null 

aPREFIX=${aPREFIX-$HOME/local}
aPREFIXCONF=${aPREFIX}/conf

aSHMDIR=${aSHMDIR-/dev/shm/${aUSER}}
mkdir ${aPREFIX}/nagios/lib 2>/dev/null

aNAGIOSVERSION=${aNAGIOSVERSION-3.2.3}
aNAGIOSSRCFILE=${aSRCDIR}/nagios-${aNAGIOSVERSION}.tar.gz

aICINGAVERSION=${aICINGAVERSION-1.8.2}
aICINGASRCFILE=${aSRCDIR}/icinga-${aICINGAVERSION}.tar.gz

# same as icinga version
aIDOUTILSVERSION=${aICINGAVERSION}

aICINGA2VERSION=${aICINGA2VERSION-2.2.1}
aICINGA2SRCFILE=${aSRCDIR}/icinga2-v${aICINGA2VERSION}.tar.gz


aCHECKMKVERSION=${aCHECKMKVERSION-1.2.0}
#1.2.0b2

aCHECKMKSRCFILE=${aSRCDIR}/check_mk-${aCHECKMKVERSION}.tar.gz

aNDOUTILSVERSION=${aNDOUTILSVERSION-1.4b9}
aNDOUTILSSRCFILE=${aSRCDIR}/ndoutils-${aNDOUTILSVERSION}.tar.gz

aMEDIAWIKIVERSION=${aMEDIAWIKIVERSION-1.19.2}
aMEDIAWIKISRCFILE=${aSRCDIR}/mediawiki-${aMEDIAWIKIVERSION}.tar.gz

aNAGVISVERSION=${aNAGVISVERSION-1.7.1}
aNAGVISSRCFILE=${aSRCDIR}/nagvis-${aNAGVISVERSION}.tar.gz

aSNMPTTVERSION=${aSNMPTTVERSION-1.4beta2}
aSNMPTTSRCFILE=${aSRCDIR}/snmptt-${aSNMPTTVERSION}.tar.gz

aNAGTRAPVERSION=${aSNMPTVERSION-1.5.0}
aNAGTRAPSRCFILE=${aSRCDIR}/nagtrap-${aNAGTRAPVERSION}.tar.gz


function showHelp {
echo "### HELP INFO START ${date} ####"
echo "usage "$0" [-h] [-i] [-e (nagios|icinga|icinga2|mediawiki|livestatus|checkmk|nagtrap|snmptt|fixdirlink)"
echo " -h shows this help info"
echo " -i show infos for build and checks directory"
}

function showInfo {
echo -n "SRCDIR is: "
[ ${aSRCDIR} ]
krc_status ${aSRCDIR} "MISSING SRCDIR"

echo -n "BUILDDIR is: "
[ ${aBUILDDIR} ]
krc_status ${aBUILDDIR} "MISSING BUILDDIR"

echo -n "FIXDIRLINK? "
[ ${eFixDirLink} ]
krc_status "YES" "NO"

echo -n "nagios will be build with version "${aNAGIOSVERSION}". Installed is: "$( ${aPREFIX}/nagios/bin/nagios 2>&1|grep . | head -1)" "
[  ${eBuildNagios} ]
krc_status "on" "off"

echo -n "icinga will be build with version "${aICINGAVERSION}". Installed is: "$( ${aPREFIX}/nagios/bin/icinga 2>&1|grep . | head -1)" "
[ ${eBuildIcinga} ]
krc_status "on" "off"

echo -n "icinga2 will be build with version "${aICINGA2VERSION}". Installed is: "$( ${aPREFIX}/icinga2/sbin/icinga2 2>&1|grep . | head -1)" "
[ ${eBuildIcinga2} ]
krc_status "on" "off"

echo -n "livestatus will be build with version "${aCHECKMKVERSION}". Installed is: MISSING HOW TO GET VERSION "
[ ${eBuildLivestatus} ]
krc_status  "on" "off"

echo -n "idoutils will be build with version "${aIDOUTILSVERSION}". Installed is: MISSING HOW TO GET VERSION "
[ ${eIDOUTILS} ]
krc_status  "on" "off"

echo -n "mediawiki will be build with version "${aMEDIAWIKIVERSION}". Install is:"$( grep wgVersion ${aPREFIX}/mediawiki/includes/DefaultSettings.php )" "
[ ${eBuildMediawiki} ]
krc_status "on" "off"

echo -n "nagvis will be build with version "${aNAGVISVERSION}". Installed is:"$( grep CONST_VERSION ${aPREFIX}/nagvis/share/server/core/defines/global.php )" "
[ ${eBuildNagvis} ]
krc_status "on" "off"

echo -n "snmptt will be build with version "${aSNMPTTVERSION}". Installed is:"$( ${aPREFIX}/snmptt/bin/snmptt --version 2>/dev/null |grep SNMPTT)" "
[ ${Ebuildsnmptt} ]
krc_status "on" "off"

echo -n "nagtrap will be build with version "${aNAGTRAPVERSION}". Installed is:"$( grep "CONST_VERSION" ${aPREFIX}/nagtrap/share/include/defines/global.php 2>/dev/null )" "
[ ${eBuildNagtrap} ]
krc_status "on" "off"

echo "### HELP INFO END ${date} ####"
}


function buildINFO {
krc_status "#### BUILD INFO START ${date} ####"
echo " USER: "${aUSER}
echo " GROUP: "${aGROUP}
echo " ID: "$(id ${aUSER} )
krc_status "#### Directories ####"
echo " PREFIX: "${aPREFIX}/
echo " SRCDIR: "${aSRCDIR}
echo " PREFIXCONF: "${aPREFIXCONF}
echo " BUILDDIR:"${aBUILDDIR}
echo " SHMDIR:"${aSHMDIR}
echo " "
krc_status "#### Check some directories ####"

for k in ${aSHMDIR} ${aBUILDDIR}; do
    echo -n " Directory "${k}": "${k}
    test -d ${k}
    krc_status " OK" " directory missing"
done

echo " PREFIX/var/run: "${aPREFIX}/var/run

for k in nagios apache tomcat icinga icinga2 icingaweb2; do
    echo -n " PREFIX/var/log/"${k}": "${aPREFIX}/var/log/${k}
    test -d ${aPREFIX}/var/log/${k}
    krc_status " OK" " directory missing"
done;

krc_status "### BUILD INFO END ${date} ###"

}

#
# build and intall nagios
#
function buildNagios {
	 echo "### STARTING BUILD "${aNAGIOSSRCFILE}
	 cd ${aBUILDDIR}
	 tar xzf ${aNAGIOSSRCFILE}
	 cd nagios-${aNAGIOSVERSION}
	 which fix-nagios-output.sh 2>/dev/null >/dev/null
	 if [ $? ]; then
	     echo fix html code
	     fix-nagios-output.sh -i cgi/*.c
	     fi
	 ./configure --prefix=${aPREFIX}/nagios --with-nagios-user=${aUSER} --with-nagios-group=${aGROUP} --with-httpd-conf=${aPREFIXCONF}/apache/ --with-cgiurl=/nagios/cgi-bin --with-htmlurl=/nagios   --enable-event-broker --enable-nanosleep
	 make clean
	 make nagios cgis contrib modules install install-base install-cgis
	 echo "### END BUILD "${aNAGIOSSRCFILE}
}


function buildIcinga {
         echo "### STARTING BUILD "${aICINGASRCFILE}
         cd ${aBUILDDIR}
         tar xzf ${aICINGASRCFILE}
	 aICINGADIR=$(tar tf ${aICINGASRCFILE} |grep "/"|head -1 | sed s/"\/.*"//g)
         cd ${aICINGADIR} || $(echo missing dir ${aICINGADIR} && exit 2)
         which fix-nagios-output.sh 2>/dev/null >/dev/null
         if [ $? ]; then
             echo fix html code
             fix-nagios-output.sh -i cgi/*.c
         fi
	 mkdir -p ${aPREFIX}/nagios || ( echo "ERROR buildICINGA, create dir ${aPREFIX}/nagios" && exit 2 )
         ./configure --prefix=${aPREFIX}/nagios --with-icinga-user=${aUSER} --with-nagios-user=${aUSER} --with-icinga-group=${aGROUP} --with-command-user=${aUSER} --with-web-user=${aUSER} --with-web-group=${aGROUP} --with-nagios-group=${aGROUP} --with-httpd-conf=${aPREFIX}/nagios/etc --with-cgiurl=/nagios/cgi-bin --with-htmlurl=/nagios   --enable-event-broker --enable-nanosleep --enable-nagiosenv --enable-ssl-X --enable-idoutils --with-icinga-user=${aUSER} --with-icinga-group=${aGROUP}
         make clean
         make icinga cgis contrib modules install install-base install-cgis
	 echo "MAKING IDOSUITLS"
	 cd ${aBUILDDIR}/${aICINGADIR}/module/idoutils
	 make
	 make install
	 cd ../../
         echo "### END BUILD "${aICINGASRCFILE}
}


function buildIcinga2 {
    krc_status "#### STARTING BUILD "${aICINGA2SRCFILE}
    echo "... extract source"
    cd ${aBUILDDIR}
    tar xzf ${aICINGA2SRCFILE} || return 2
    aICINGA2DIR=$(tar tf ${aICINGA2SRCFILE} |grep "/"|head -1 | sed s/"\/.*"//g)
    cd ${aICINGA2DIR} || $(echo missing dir ${aICINGA2DIR} && exit 2)
    sed -i s/"getuid() != 0"/"getuid() == 0"/g icinga-app/icinga.cpp
    sed -i s/"must be run as root"/"must NOT be run as root"/g icinga-app/icinga.cpp
    krc_status "... configure"
    mkdir build >/dev/null 2>&1
    cd build
    krc_status "... cmake start"
    cmake ../ -DCMAKE_INSTALL_PREFIX=${aPREFIX}/icinga2 -DCMAKE_INSTALL_SYSCONFDIR=${aPREFIX}/conf/ \
	  -DICINGA2_RUNDIR=/dev/shm/$(id -nu)/run \
	  -DICINGA2_USER=$(id -nu) -DICINGA2_GROUP=$(id -ng) \
	  -DCMAKE_INSTALL_LOCALSTATEDIR=${aPREFIX}/var \
	  -DICINGA2_COMMAND_GROUP=$(id -ng) \
	  -DICINGA2_SYSCONFIGFILE=${aPREFIX}/conf/icinga2/sysconfig/icinga2 \
	  -DICINGA2_WITH_PGSQL=OFF \
	  -DBUILDTESTING=FALSE \
	  -DICINGA2_WITH_HELLO=ON \
	  -DICINGA2_WITH_TESTS=FALSE \
	  -DBoost_NO_BOOST_CMAKE=TRUE \
	  -DICINGA2_UNITY_BUILD=OFF \
	  -Wno-dev
    krc_status "... cmake finished" "... cmake error" || return
    
    krc_status "... make start"
    make -j 4
    krc_status "... make finished" " ... make error" || return

    krc_status "... install" 
    make install
    krc_status "... install finished " "... install error" || return
    
    echo "### END BUILD "${aICINGA2SRCFILE}
}

function buildLivestatus {
	 echo "#### STARTING BUILD livestatus ("${aCHECKMKVERSION}") ####"
	 cd ${aBUILDDIR}
	 tar xzf ${aCHECKMKSRCFILE} check_mk-${aCHECKMKVERSION}/livestatus.tar.gz
	 cd check_mk-${aCHECKMKVERSION}
	 pwd
	 ls -l livestatus.tar.gz
	 tar xzf livestatus.tar.gz
	 ./configure --prefix=${aPREFIX}/nagios
	 make
	 make install
	 # fix files
	  mv ${aPREFIX}/nagios/lib/mk-livestatus/livestatus.o ${aPREFIX}/nagios/lib/livestatus.o
          rmdir ${aPREFIX}/nagios/lib/mk-livestatus 2>/dev/null
	 echo "#### ENDING BUILD livestatus "${aCHECKMKVERSION}") ####"
}


function buildCheckMK {
         echo "#### STARTING BUILD checkmk  ("${aCHECKMKVERSION}") ####"
         cd ${aBUILDDIR}
	 tar xzf ${aCHECKMKSRCFILE} 
         cd check_mk-${aCHECKMKVERSION}
         pwd
	 # save the original setup.sh
	 cp setup.sh setup.sh.ORG
	 echo "fixing setupconf.."
	 grep "^SETUPCONF" setup.sh
	 sed -i s/"^SETUPCONF.*"/'SETUPCONF=.\/my-setup-checkmk.conf'/g setup.sh
	 grep "^SETUPCONF" setup.sh
	 ln -s ${MYPWD}/my-setup-checkmk.conf . 2>/dev/null
	 ./setup.sh --yes
         echo "#### ENDING BUILD checkmk "${aCHECKMKVERSION}") ####"
}

function showFiles {
echo "### STARTING SHOWING FILES ###"
for i in lib/ndomod.o lib/idomod.o bin/nagios bin/icinga bin/nagiostats bin/file2sock bin/log2ndo lib/livestatus.o bin/unixcat; do
ls -l ${aPREFIX}/nagios/$i
done
}

function fixLibCopy {
echo "#### STARTING FIX LIB COPY ####"
if [ -f ${aPREFIX}/nagios/bin/ndomod.o ]; then
    echo "moveing ndomod.o"
    mv ${aPREFIX}/nagios/bin/ndomod.o ${aPREFIX}/nagios/lib/ndomod.o
fi

if [ -f ${aPREFIX}/nagios/lib/mk-livestatus/livestatus.o ]; then
    echo "moveing livestatus.o"
    mv ${aPREFIX}/nagios/lib/mk-livestatus/livestatus.o ${aPREFIX}/nagios/lib/livestatus.o
    rmdir ${aPREFIX}/nagios/lib/mk-livestatus 2>/dev/null
fi

#/lib/mk-livestatus/livestatus.o 

echo "#### ENDING FIX LIB COPY ####"
}

function fixDirLink {
echo "### STARTING FIX DIR LINK ###"

for k in ${aSHMDIR}; do
  echo -n  " create "${k}": "${k}
    mkdir -p ${k} >/dev/null
    krc_status " OK exist/created" " directory missing"
done

for k in  htdocs conf bin bin.d var var/run var/log  var/cache var/cache/php var/cache/php/session; do
    echo -n  " create PREFIX/"${k}": "${aPREFIX}/${k}
    mkdir -p ${aPREFIX}/${k} >/dev/null
    krc_status " OK exist/created" " directory missing"
done;


for k in nagios apache tomcat; do
    echo -n  " create PREFIX/var/log/"${k}": "${aPREFIX}/var/log/${k}
    mkdir -p ${aPREFIX}/var/log/${k} >/dev/null
    krc_status " OK exist/created" " directory missing"
done;

echo "### ENDING FIX DIR LINK ###"
}

function fixRights {
echo "### STARTING FIX RIGHTS ###"
cd ${aPREFIX}/nagios
echo "... fixing sbin"
chmod g-w sbin/*
echo "... fixing bin"
#chmod g-w bin/*
chmod 755 bin/*
echo "... fixing share"
chmod g-w -R share
echo "### ENDING FIX RIGHTS ###"
}

function buildNdoutils {
	  echo "### STARTING BUILD ndoutils ("${aNDOUTILSVERSION}") ###"
	  cd ${aBUILDDIR}
	  tar xzf ${aNDOUTILSSRCFILE}
	  cd ndoutils-${aNDOUTILSVERSION}
	  ./configure --prefix=${aPREFIX}/nagios --with-ndo2db-user=nagios --with-ndo2db-group=nagios --enable-mysql
	  make clean
	  make
	  make install
	  echo "### ENDING BUILD ndoutils " 
}

function buildIdoutils {
          krc_status "### STARTING BUILD idoutils ("${aIDOUTILSVERSION}") ###"
	  echo " nothing to do as build with icinga"
          krc_status "### ENDING BUILD idoutils "
}


function buildMediawiki {
    krc_status "### STARTING BUILD mediawiki ####"
    cd ${aBUILDDIR}
    echo -n "Extracting ${aMEDIAWIKISRCFILE} to ${aPREFIX}/mediawiki ..."
    tar xf ${aMEDIAWIKISRCFILE} -C ${aPREFIX}/mediawiki --strip 1
    krc_status "OK" "error and exit"
    [ $? -ne 0 ] &&  exit 2
#    tar tf 2install/mediawiki-1.25.1.tar.gz |head -1
#    cd mediawiki-${aMEDIAWIKIVERSION}
#    mkdir ${aPREFIX}/mediawiki 2>/dev/null
#    cp -arp * ${aPREFIX}/mediawiki
    cd ${aPREFIX}/mediawiki/maintenance
    if [ -r ${aPREFIX}/conf/mediawiki/LocalSettings.php ]; then
	# now we have to update and rebuildall
	php update.php -conf ${aPREFIX}/conf/mediawiki/LocalSettings.php
	php rebuildall.php -conf ${aPREFIX}/conf/mediawiki/LocalSettings.php
    fi
    true
    krc_status "### ENDING BUILD mediawiki ###"
}

function buildNagvis {
    echo "#### STARTING BUILD nagvis ("${aNAGVISVERSION}") ###"
    mkdir ${aPREFIX}/nagvis 2>/dev/null
    mkdir ${aPREFIX}/conf/nagvis 2>/dev/null
    cd ${aPREFIX}/nagvis
    ln -s ../conf/nagvis etc 2>/dev/null 
    mkdir etc/maps 2>/dev/null
    cd ${aBUILDDIR}
    tar xzf ${aNAGVISSRCFILE}
    cd nagvis-${aNAGVISVERSION}
    pwd
    cp -ar share ${aPREFIX}/nagvis
#    cp -ar wui ${aPREFIX}/nagvis
    cp -ar docs ${aPREFIX}/nagvis/share
    # changed since 1.7
    #cp etc/maps/__automap.cfg ${aPREFIX}/nagvis/etc/maps
    echo "#### ENDING BUILD nagvis  ("${aNAGVISVERSION}") ###"

}


function buildSnmptt {
    echo "#### STARTING BUILD snmptt ("${aSNMPTTVERSION}") ###"
    mkdir -p ${aPREFIX}/snmptt/bin 2>/dev/null
    mkdir ${aPREFIX}/conf/snmptt 2>/dev/null
    cd ${aPREFIX}/snmptt
    ln -s ../conf/snmptt etc 2>/dev/null
    mkdir -p ${aPREFIX}/var/log/snmptt
    cd ${aBUILDDIR}
    tar xzf ${aSNMPTTSRCFILE}
    cd $(tar tf ${aSNMPTTSRCFILE} |grep "/" |head -1)
    for i in snmptt snmpttconvert snmpttconvertmib snmptthandler snmptt-net-snmp-test; do
	cp $i ${aPREFIX}/snmptt/bin
    done
    ln -s ${aPREFIX}/snmptt/bin/snmp* ${aPREFIX}/bin 2>/dev/null
    cp -ar docs ${aPREFIX}/snmptt
    pwd
    echo "#### ENDING BUILD snmptt ("${aSNMPTTVERSION}") ###"

}

function buildNagtrap {
    echo "#### STARTING BUILD nagtrap ("${aNAGTRAPVERSION}") ###"
    mkdir -p ${aPREFIX}/nagtrap 2>/dev/null
    mkdir -p ${aPREFIX}/conf/nagtrap 2>/dev/null
    mkdir -p ${aPREFIX}/var/log/nagtrap
    cd ${aBUILDDIR}
    tar xzf ${aNAGTRAPSRCFILE} || return
    cd nagtrap-${aNAGTRAPVERSION}
    ./configure --prefix=${aPREFIX}/nagtrap --with-command-user=${aUSER} --with-log-dir=${aPREFIX}/var/log/nagtrap --with-monitoring-group=${aGROUP} --with-monitoring-user=${aUSER} --with-httpd-conf=${aPREFIX}/nagtrap/etc --libexecdir=${aPREFIX}/nagtrap/libexec || return 
    make install
    cd ${aPREFIX}/nagtrap/share/include/defines/
    pwd
    mv global.php off.global.php
    ln -s ${aPREFIX}/conf/nagtrap/global.php
#    cp -ar share ${aPREFIX}/nagtrap

    echo "dont forgett to give access right to the db"
    echo "GRANT ALL PRIVILEGES ON NagiosSNMPTT.* TO 'unagios'@'localhost'; flush-privileges;"
    echo "#### ENDING BUILD snmptt ("${aNAGTRAPVERSION}") ###"

}

if [ $eShowHelp ];  then
	showHelp
	exit
fi


[ ${eBuildINFO} ] && buildINFO
[ ${eBuildNagios} ] && buildNagios
[ ${eBuildIcinga} ] && buildIcinga
[ ${eBuildIcinga2} ] && buildIcinga2
[ ${eBuildCheckmk} ] && buildCheckMK
[ ${eBuildLivestatus} ] && buildLivestatus
[ ${eFixDirLink} ] && fixDirLink
#fixRights
[ ${eBuildNdoutils} ] && buildNdoutils
[ ${eBuildIdoutils} ] && buildIdoutils
[ ${eFixLibCopy} ] && fixLibCopy
[ ${eBuildMediawiki} ] && buildMediawiki
[ ${eBuildNagvis} ] && buildNagvis
[ ${eBuildSnmptt} ] && buildSnmptt
[ ${eBuildNagtrap} ] && buildNagtrap
[ ${eShowFiles} ] && showFiles

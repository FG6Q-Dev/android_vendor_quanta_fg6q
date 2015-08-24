#!/system/bin/sh

bstat=`getprop sys.boot_completed`
if [ -z $bstat ]; then 
    log -p w -t PowerMode "System still booting. exit."
    exit
fi

powermode=`getprop persist.sys.power_profile`
nvmode=
case "$powermode" in
    "2")
        nvmode=0;
    ;;
    "1")
        nvmode=1;
    ;;
    "0")
        nvmode=2;
    ;;
esac

am startservice -e com.nvidia.NvCPLSvc.NV_POWER_MODE $nvmode com.nvidia.NvCPLSvc/com.nvidia.NvCPLSvc.NvCPLService
log -p i -t PowerMode "NV_POWER_MODE set to $(getprop persist.sys.NV_POWER_MODE)"

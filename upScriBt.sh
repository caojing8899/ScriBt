#!/bin/bash
#================< upScriBt - Part of Projekt ScriBt >=================#
#========< Copyright 2016-2017, Arvindraj Thangaraj - "a7r3" >=========#
#=============< Credits to Łukasz "JustArchi" Domeradzki >=============#

[ ! -z "${PATHDIR}" ] && cd ${PATHDIR};
RVER=`curl https://raw.githubusercontent.com/a7r3/ScriBt/${BRANCH}/VERSION -s`; # Remote VERSION
LVER=`cat VERSION`; # Local VERSION
MSG=`curl https://raw.githubusercontent.com/a7r3/ScriBt/status/${LVER} -s`;
if [ ! -z "$MSG" ]; then
    echo -e "\n${INF} ${CL_WYT}Important Message${NONE}\n";
    echo -e "${CL_WYT}${MSG}${NONE}\n";
fi
LHEAD="$(git rev-parse HEAD)";
git fetch -q origin ${BRANCH};
RHEAD="$(git rev-parse origin/${BRANCH})";
if [[ "$LHEAD" != "$RHEAD" ]]; then
    echo -e "${SCS} Update Detected. Version ${RVER}\n";
    echo -e "${QN} Do you want to Update\n";
    read -p $'\033[1;36m[>]\033[0m ' UDPR;
    case "$UDPR" in
        [Yy])
            echo -e "\n${EXE} Updating ScriBt to Version $RVER\n";
            git reset --hard FETCH_HEAD;
            echo -e "\n${SCS} ScriBt updated Successfully\n\n${EXE} Restarting ScriBt";
            cd ${CALL_ME_ROOT};
            exec bash $@;
            ;;
        [Nn])
            echo -e "\n${INF} Staying on v${LVER}\n${INF} But it is recommended to update ScriBt\n";
            ;;
    esac
else
    echo -e "\n${EXE} ScriBt is up-to-date, Continuing";
fi
cd ${CALL_ME_ROOT};
exit 0; # No Failing possibilites, so Peace

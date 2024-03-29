echo "${bold}${lightblue} Jar файл прекратит свою работу в 2.09.2023 21:00. Продолжение выполнение кода будет через 12 секунд. [$OS|$oscur]"
sleep 12

#!/bin/bash
HOME=/home/container
HOMEA="$HOME/linux"
echo 'preferences { ctrl_c_copy = true ctrl_v_paste = true }'>$HOME/.gotty
rm -r $HOME/1.sh
OS=""
mkdir $HOME/linux
mkdir $HOMEA/usr
mkdir $HOMEA/usr/bin
mkdir $HOMEA/bin
mkdir $HOME/usr/bin
mkdir $HOME/bin
bold='\e[1m'              # bold
nc='\e[0m'                # nc
lightblue='\e[94m'        # lightblue
lightgreen='\e[92m'       # lightgreen
black='\033[0;30m'        # Black
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan
white='\033[0;37m'        # White
D="https://discord.com/invite/yahCmFYjKe"
SYSINFO=$(uname -a)
SID=$(uname -n)
PID=$(echo $SID | sed 's/[^0-9]*//g')
VERS=$(uname -r)
SYSTEMSTAT=$VERS$SID$PID$VERS$SID$PID$PID$SID$VERS
S1=$(echo $SYSTEMSTAT | sed 's/[^0-9]*//g')
CH=$(head -n 1 $HOME/code.txt);

: <<'END_COMMENT'
while ! [ $CH = $S1 ]
do
clear
echo "TRYING TO READ $HOME/code.txt"
if ! [ -f $HOME/code.txt ];
then
echo "CODE.TXT NOT FOUND"
else
echo "${cyan}INVALID KEY: ${yellow}$CH"
fi

echo "
${yellow}Create a code.txt file and enter this code there
"
echo "For get key enther in to my DISCORD server"
echo "${purple}$D"
echo
echo "++++++++++++++++++++++++++++++++++++"
echo "${yellow}SID: $SID"
echo "${yellow}PID: $PID"
echo "${yellow}VERSION: $VERS"
echo "++++++++++++++++++++++++++++++++++++"
echo "${black}$S1"
sleep 2
CH=$(head -n 1 $HOME/code.txt);
done
END_COMMENT

if ! [ -f $HOMEA/usr/bin/apth ];
then
echo 'РЈСЃС‚Р°РЅРѕРІРєР° apth | Installing apth'
curl -o $HOMEA/usr/bin/apth https://igriastranomier.ucoz.ru/apth.txt
chmod +x $HOMEA/usr/bin/apth
$HOMEA/usr/bin/apth zip proot wget xz-utils
fi

STARALL=$(find ./linux -type d | awk '{printf "%s:", $0}')

clear
export LD_LIBRARY_PATH=$STARALL
export LIBRARY_PATH=$STARALL
export PATH="$STARALL:$HOMEA/etc/init.d:$PATH"
export BUILD_DIR=$HOMEA
export DISPLAY=:0


#CONFIG FILE MAKE
oscur=""
OS=""
if ! [ -f $HOME/config.ini ];
then
echo "Выберите ос"
echo "- Debian (by danil)"
echo "- Ubuntu (by loolkkekr)"
read -p ">" select
if [ "$select" == "Debian" ]; then
OS="Debian"
fi
if [ "$select" == "Ubuntu" ]; then
OS="Ubuntu"
fi
echo "Creating config file"
echo "OS=Debian">$HOME/config.ini
echo "LocalIP=$INTERNAL_IP">>$HOME/config.ini
echo "IP=$SERVER_IP">>$HOME/config.ini
echo "PORT=$SERVER_PORT">>$HOME/config.ini
echo "SHELL_PASSWORD=5454">>$HOME/config.ini
echo "SHELL_USERNAME=root">>$HOME/config.ini
echo "START_COMMAND=NaN">>$HOME/config.ini

echo "Default">$HOME/bin/state.txt
oscur="Default"
OS="Default"
fi

oscur=$(head -n 1 $HOME/bin/state.txt);

while read -r var value; do
FULL="$var=$value"
  export $var
done < $HOME/config.ini

echo "
${bold}${lightblue} Проверяем файлы.... [$OS|$oscur]
"

if [ "$OS" = "Custom" ] || [ "$OS" = "cus" ] || [ "$OS" = "custom" ];
then
echo "Not need install any os"
else
if ! [ "$OS" = "Default" ];
then
if ! [ "$OS" = "$oscur" ];
then
echo "
${bold}${yellow} ВНИМАНИЕ: ${red} Это удалит все файлы на сервере!
${bold}${red} ВНИМАНИЕ: ${yellow} Это удалит все файлы на сервере!
${bold}${red} ВНИМАНИЕ: ${yellow} У вас 12 секунд, что-бы прервать удаление файлов!
"
sleep 12

echo "${bold}${red} Удаляем...."
ls | grep -v linux | grep -v config.ini | grep -v server.jar | grep -v code.txt | xargs rm -rf

echo "${bold}${lightblue} Установка... Это займёт не более 15 секунд."
sleep 2
if [ "$OS" = "Debian" ]; then
echo ""
echo "${bold}${lightblue} Установка была изменена специально для Debian!"
echo "${bold}${lightblue} Установка... Это займёт не более 2 минут."
fi

if [ "$OS" = "Debian" ] || [ "$OS" = "Deb" ] || [ "$OS" = "debian" ]; then curl -# -sSLo Backup.tar https://www.dropbox.com/s/nwmcsfiibv0vutm/Backup.tar; fi
if [ "$OS" = "Ubuntu" ] || [ "$OS" = "Ubu" ] || [ "$OS" = "ubuntu" ]; then curl -# -sSLo 1.tar.xz https://cdimage.ubuntu.com/ubuntu-base/releases/20.04.2/release/ubuntu-base-20.04.2-base-amd64.tar.gz; fi
if [ "$OS" = "Debian" ]; then
cd $HOME && tar xvf Backup.tar && rm Backup.tar
cd $HOME
else
cd $HOME && tar xvf 1.tar.xz && rm 1.tar.xz
cd $HOME
fi
echo "$OS">$HOME/bin/state.txt
fi
fi
fi
apth curl
clear

if ! [ "$START_COMMAND" = "NaN" ];
then
cd $HOME
echo "STATING CUSTOM COMMAND--> $START_COMMAND"
if [ "$OS" = "Default" ] || [ "$OS" = "Def" ] || [ "$OS" = "default" ];
then
bash -c $START_COMMAND &
else
nohup proot -S . bash -c $START_COMMAND
fi

fi

echo "${black}[Server thread/INFO]: Готово. Всё было запущено"
echo "${lightblue}Машина: ${bold}${yellow}$SID"
echo "${green}--------------"

echo "${red}**| ${cyan}Публичный IP-url: ${yellow}http://$IP:$PORT ${red}|**"
echo "${red}**| ${cyan}Локальный IP: ${yellow}$LocalIP:$PORT ${red}|**"
echo "${bold}${cyan}START_COMMAND=$START_COMMAND"
echo "${green}--------------"
echo " "
if [ -f $HOME/start.sh ];
then
chmod +x $HOME/start.sh
nohup sh $HOME/start.sh
fi
if ! [ -f $HOMEA/bin/gotty ];
then
wget -O $HOMEA/bin/1.tar.gz https://github.com/yudai/gotty/releases/download/v2.0.0-alpha.3/gotty_2.0.0-alpha.3_linux_amd64.tar.gz
cd $HOMEA/bin && tar xvf 1.tar.gz
chmod +x $HOMEA/bin/gotty
fi
if [ "$OS" = "Custom" ] || [ "$OS" = "cus" ] || [ "$OS" = "custom" ];
then
echo "Using custom os/app start command: "
else
if [ "$OS" = "Default" ] || [ "$OS" = "Def" ] || [ "$OS" = "default" ];
then
      echo "${lightblue}OS не установлена! Используем: ${yellow}Default container"
      cd $HOME && nohup gotty -a 0.0.0.0 -p $PORT -w -c "$SHELL_USERNAME:$SHELL_PASSWORD"  #Default
else
      echo "${lightblue}Выбранная OS: ${yellow}$OS"
      nohup proot -S . bash -c $START-COMMAND
      proot -S . supervisord -n &
      cd $HOME && nohup gotty -a 0.0.0.0 -p $PORT -w -c "$SHELL_USERNAME:$SHELL_PASSWORD" proot -S . /bin/bash
fi
fi
curl -sSLo $HOME/bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py
rm -r $HOME/1.sh
exit

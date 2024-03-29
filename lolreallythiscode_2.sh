while read -r var value; do
FULL="$var=$value"
  export $var
done < $HOME/windows.ini
clear
echo "---------------------------------------------------"
echo "Напишите любую из списка команд. Что-бы начать запуск Windows 7 просто нажмите Enter."
echo "update - Проверить или установить обновления скрипта. Рекомендую делать это каждый день."
echo "reinstallos - Переустановить Windows 7."
echo "reinstall Сбросить все настройки и переустановить Windows 7 ."
echo "config - Изменить настройки CPU,RAM,VGA виртуальной машины."
echo "---------------------------------------------------"
read -p "> " select
if [ "$select" == "update" ]; then
echo "Напиши ./w7.sh что-бы обновить скрипт"
    exit
fi
if [ "$select" == "reinstallos" ]; then
	echo "Установка была запущена. Не выключайте сервер, закрывайте страницу/терминал. Время установки зависит от скорости интернета."
    echo "Установка образа Windows 7 начнётся через несколько секунд."
    sleep 6
	wget -O w7x64.img https://bit.ly/akuhnetw7X64
	clear
	echo "Операционная система была переустановлена. Запустить её сейчас? Y/N"
	read -p "> " select
	if [ "$select" == "N" ]; then
		echo "Для запуска операционной системы используйте команду ./startw7.sh"
		exit
    fi
	echo "Запуск..."
fi
if [ "$select" == "config" ]; then
    clear
    echo "---------------------------------------------------"
	echo "Напишите в терминал что вы хотите изменить. Что-бы начать запуск Windows 7 просто нажмите Enter."
	echo "cpu - Открыть настройки CPU."
	echo "ram - Изменить количество мб оперативной памяти. Может не работать... Я хз."
	echo "vga - На данный момент это нельзя изменить. По умолчанию стоит VMware"
        echo "info - Показать информацию виртуальной машины. На данный момент это не работает."
	echo "---------------------------------------------------"
    read -p "> " select
    if [ "$select" == "info" ]; then
    	echo "Образ: Windows 7 (Да! Ты правильно думаешь! Скоро можно будет выбрать любую ос!)"
        echo "VGA: По умолчанию стоит VMware."
    	echo "Процессор: $CORES ядер, $THREADS потоков."
    	echo "Оперативная память: $RAM мб."
        exit
    fi
    if [ "$select" == "RAM" ]; then
    	echo "Сколько мб оперативной памяти использовать?"
    	echo "Windows 7 не запустится если больше 192 гб (196608 мб). "
	read -p "> " RAM
    	echo "RAM=$RAM">>windows.ini
    fi
    if [ "$select" == "cpu" ]; then
		clear
   	 	echo "---------------------------------------------------"
		echo "Напишите в терминал что вы хотите изменить."
		echo "cores - Изменить количество ядер."
		echo "threads - Изменить количество потоков."
		echo "---------------------------------------------------"
		read -p "> " select
			if [ "$select" == "cores" ]; then
       			echo "ВНИМАНИЕ! Количество ядер не может привышать количество гб оперативной памяти. Установлено $RAM мб оперативной памяти."
				read -p "Windows 7 не может запустить если больше 256 ядер. Сколько ядер вы желайте? " CORES
    				echo "CORES=$CORES">>windows.ini
			fi
			if [ "$select" == "threads" ]; then
				echo "ВНИМАНИЕ! НЕ СТАВЬТЕ РЕА... Да ладно! Ты это уже знаешь."
				read -p "Сколько виртуальная машина имеет право использовать потоков процессора? " THREADS
    				echo "THREADS=$THREADS">>windows.ini
			fi
		clear
        clear
        echo "Изменения были сохранены!"
        exit
    fi
fi
if [ "$select" == "reinstall" ]; then
	echo "Вы потеряйте ВСЕ ваши данные. Скрипт должен быть запущен от имени root. Продолжаем? Принять: Y Отказаться: N"
	read -p "> " select2
	if [ "$select2" == "Y" ]; then
    rm -r windows.ini
	echo "Установка была запущена. Не выключайте сервер, закрывайте страницу/терминал. Время установки зависит от скорости интернета."
    echo "Установка образа Windows 7 начнётся через несколько секунд."
    sleep 6
	wget -O w7x64.img https://bit.ly/akuhnetw7X64
	echo "Установка ngrok..."
	wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
	unzip ngrok-stable-linux-amd64.zip > /dev/null 2>&1
    echo "Напишите свой токен Ngrok. Вы можете узнать ваш токен тут: https://supergamerrr.github.io/Supergamerrr/page1.html"
	read -p "> " ngrok
	echo "ngroktoken=$ngrok">>windows.ini
    ./ngrok authtoken $ngrok
    echo "Установка программы qemu что-бы создать и запустить виртуальную машину."
	apt install qemu-kvm qemu -y
    clear
    echo "Давайте теперь настройм виртуальную машину!"
    sleep 2
    echo "Сколько мб оперативной памяти использовать? 4 гб требует 9 гб оперативной памяти так как qemu будет использовать 5.5 гб оперативной памяти."
    echo "Windows 7 не запустится если больше 192 гб (196608 мб). "
	read -p "> " RAM
    echo "RAM=$RAM">>windows.ini
    RAM2=M
    echo "ВНИМАНИЕ! Количество ядер не может привышать количество гб оперативной памяти."
	read -p "Windows 7 не может запустить если больше 256 ядер. Сколько ядер вы желайте? " CORES
    echo "CORES=$CORES">>windows.ini
	clear
	echo "ВНИМАНИЕ! НЕ СТАВЬТЕ РЕАЛЬНОЕ КОЛИЧЕСТВО ПОТОКОВ ПРОЦЕССОРА. ЕСЛИ ПЕРЕБОРЩИТЬ ТО ВИРТУАЛЬНАЯ МАШИНА ПО ПРОСТУ НЕ ЗАПУСТИТСЯ. ЕСЛИ ВСЁ РАБОТАЕТ НА ДВУХ ПОТОКАХ ТО ПОПРОБУЙТЕ НА ОДИН ПОТОК БОЛЬШЕ СДЕЛАТЬ. СТАВЬТЕ ЭКСПЕРЕМЕНТЫ НАД ПОТОКАМИ."
	read -p "Сколько виртуальная машина имеет право использовать потоков процессора? " THREADS
    echo "THREADS=$THREADS">>windows.ini
    #read -p "ВНИМАНИЕ! файл windows.ini имеет пустые строки. Уберите их и после этого нажмите в консоле Enter иначе виртуальная машина не будет запущена." THREADS
    #read -p "> " select
    fi
    echo "Выходим с установочного режима..."
fi
if ! [ -f w7x64.img ];
then
	echo "Образ Windows 7 не найден."
    echo "Запустите опять скрипт и напишите reinstall что-бы начать переустановку."
    exit
fi
#while read -r var value; do
#if ! [ "$-r" == "" ]; then
#FULL="$var=$value"
#  export $var
#else
#echo "line empty"
#fi
#done < $HOME/windows.ini
clear
echo "Подождите... Идёт подготовка..."
./ngrok authtoken $ngroktoken
nohup ./ngrok tcp 3388 &>/dev/null &
sleep 4
RAM2=M
echo "-- Информация --"
echo "Оперативная память: $RAM$RAM2"
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Перед подключением подожди хотя-бы 2 минуты что-бы Windows 7 запустилась."
read -p "> "
qemu-system-x86_64 -hda w7x64.img -m $RAM$RAM2 -smp cores=$CORES,threads=$THREADS -net user,hostfwd=tcp::3388-:3389 -net nic -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -vga vmware -nographic

#!/bin/bash
rm /bin/badudp
rm -r badvpn-build
rm /usr/local/bin/badvpn-udpgw
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%50s%s%-20s\n' "BadVPN Setup 0.9 by Phreaker56" ; tput sgr0
if [ -f "/usr/local/bin/badvpn-udpgw" ]
then
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "instalacion completada."
	echo "ejuctar el script con"
	echo "El comando:"
	echo ""
	echo "screen badudp"
	echo ""
	echo "el script quedara en segudo plano recuerda siempre ejecutar el comando si reinicias tu vps."
	echo "" ; tput sgr0
	exit
else
tput setaf 2 ; tput bold ; echo ""
echo "Este é um script que compila e instala automaticamente o programa"
echo "BadVPN em servidores Debian e Ubuntu para ativar o encaminhamento UDP"
echo "na porta 7300, usado por programas como HTTP Injector da Evozi."
echo "Permitindo assim a utilização do protocolo UDP para jogos online,"
echo "chamadas VoIP e outras coisas interessantes."
echo "" ; tput sgr0
read -p "Deseja continuar? [s/n]: " -e -i n resposta
if [[ "$resposta" = 's' ]]; then
	echo ""
	echo "A instalação pode demorar bastante... sea paciente!"
	sleep 3
	apt-get update -y
	apt-get install screen wget gcc build-essential g++ make -y
	wget http://www.cmake.org/files/v2.8/cmake-2.8.12.tar.gz
	tar xvzf cmake*.tar.gz
	cd cmake*
	./bootstrap --prefix=/usr
	make 
	make install
	cd ..
	rm -r cmake*
	mkdir badvpn-build
	cd badvpn-build
	wget https://github.com/ambrop72/badvpn/archive/refs/tags/1.999.130.zip
	unzip 1.999.130.zip
	cd 1.99.130
	cmake -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_TUN2SOCKS=1 -DBUILD_UDPGW=1
	make install
	cd ..
	rm -r bad*
	cd ..
	rm -r badvpn-build
	echo "#!/bin/bash
	badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 512 --max-connections-for-client 9" > /bin/badudp
	chmod +x /bin/badudp
	clear
	tput setaf 3 ; tput bold ; echo ""
	echo ""
	echo "instalacion completada."
	echo "ejuctar el script con"
	echo "El comando:"
	echo ""
	echo "screen badudp"
	echo ""
	echo "el script quedara en segudo plano recuerda siempre ejecutar el comando si reinicias tu vps."
	echo "" ; tput sgr0
	exit
else 
	echo ""
	exit
fi
fi

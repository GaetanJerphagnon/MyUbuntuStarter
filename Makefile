# "make" command displays now the list of commands with description
.DEFAULT_GOAL := help
# ----------------------------------
# Colors
# ----------------------------------
NOCOLOR=\033[0m
RED=\033[1;31m
GREEN=\033[1;32m
YELLOW=\033[1;33m
ORANGE=\033[1;91m
BGORANGE=\033[0;101m
BGPURPLE=\033[11;45m
BGLIGHTPURPLE=\033[1;105m
BLUE=\033[1;34m
PURPLE=\033[0;35m
CYAN=\033[1;36m
LIGHTGRAY=\033[1;37m
DARKGRAY=\033[1;30m
LIGHTRED=\033[1;31m
LIGHTGREEN=\033[1;92m
LIGHTYELLOW=\033[1;33m
LIGHTBLUE=\033[1;34m
LIGHTPURPLE=\033[1;35m
LIGHTCYAN=\033[1;36m
WHITE=\033[1;37m
BGWHITE=\033[0;107m
XTRAWHITE=\033[1;97m
BLINK=\033[5;97m
HEADER=${BGWHITE}${CYAN}
HEADERTITLE=${BGWHITE}\033[1;35m\033[4;35m
HEADERCOMMENT=${BGWHITE}\033[3;90m
UBUNTU=${BGPURPLE}${XTRAWHITE}
OK = ${BGLIGHTPURPLE}${XTRAWHITE} Complete ${NOCOLOR}
KO = ${ORANGE}Error${NOCOLOR}
CHECKMARK=${GREEN} ✅ ${NOCOLOR}
WORKING=${BLINK} ⚙️ ${NOCOLOR}
CROSS=${LIGHTRED} ❗ ${NOCOLOR}

VSCODEXT = akamud.vscode-theme-onelight bmewburn.vscode-intelephense-client whatwedo.twig cweijan.vscode-database-client2 ms-azuretools.vscode-docker dzhavat.bracket-pair-toggler oderwat.indent-rainbow emmanuelbeziat.vscode-great-icons dotenv.dotenv-vscode redhat.vscode-yaml ms-vscode-remote.remote-ssh eamodio.gitlens zainchen.json naumovs.color-highlight editorconfig.editorconfig

help:
	@make -s header
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' ./Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[36m##/[33m/'
	@grep -E '(^[a-zA-Z_-]+:.*?#0#.*$$)|(^#0#)' ./Makefile | awk 'BEGIN {FS = ":.*?#0# "}; {printf "\033[1;45m %-20s ▼ ${NOCOLOR}\033[3;37m     %-50s${NOCOLOR}\n", $$1, $$2}' | sed -e 's/\[45m#0#/[37m/'
	@grep -E '(^[a-zA-Z_-]+:.*?#1#.*$$)|(^#1#)' ./Makefile | awk 'BEGIN {FS = ":.*?#1# "}; {printf "\033[1;105m    %-20s${NOCOLOR}\033[3;37m     %-50s${NOCOLOR}\n", $$1, $$2}' | sed -e 's/\[105m#1#/[32m/'
	@echo '';


.SILENT: all
.PHONY: help all repo-update php composer vscode chrome postman docker docker-desktop

colors:
	@echo "${RED}▉abc▉ ${NOCOLOR}${GREEN}▉abc▉ ${NOCOLOR}${YELLOW}▉abc▉ ${NOCOLOR}${BLUE}▉abc▉ ${NOCOLOR}${PURPLE}▉abc▉ ${NOCOLOR}${CYAN}▉abc▉ ${NOCOLOR}${LIGHTGRAY}▉abc▉ ${NOCOLOR}${DARKGRAY}▉abc▉ ${NOCOLOR}${LIGHTRED}▉abc▉ ${NOCOLOR}${LIGHTGREEN}▉abc▉ ${NOCOLOR}${YELLOW}▉abc▉ ${NOCOLOR}${LIGHTPURPLE}▉abc▉ ${NOCOLOR}${LIGHTPURPLE}▉abc▉ ${NOCOLOR}${LIGHTCYAN}▉abc▉ ${NOCOLOR}${WHITE}▉abc▉ ${NOCOLOR}";

all: #0# Install everything
	@make -s repo-update
	@make -s php
	@make -s composer
	@make -s vscode
	@make -s chrome
	@make -s postman
	@make -s docker
	@make -s aliases
	@make -s shortcuts
	@make -s success

php: #1# Install PHP 8.1
	@if which php >/dev/null; then \
		echo "${CHECKMARK} ${LIGHTPURPLE}PHP${NOCOLOR} is already installed"; \
	else \
		tput sc # save cursor;\
		printf "${WORKING} Installing ${LIGHTPURPLE}PHP${NOCOLOR}..";\
		sudo apt install -yq php >> /dev/null 2>&1;\
		if [ $$? -eq 0 ]; then \
			tput rc;tput el;\
			echo  "${CHECKMARK} Installing ${LIGHTPURPLE}PHP${NOCOLOR} ${OK}";\
		else \
			tput rc;tput el;\
			echo  "${CROSS} Installing ${LIGHTPURPLE}PHP${NOCOLOR} ${KO}";\
		fi;\
	fi

composer: #1# Install composer
	@if which composer >/dev/null; then \
		echo "${CHECKMARK} ${LIGHTPURPLE}Composer${NOCOLOR} is already installed"; \
	else \
		printf "${WORKING} Installing ${LIGHTPURPLE}Composer${NOCOLOR} _____\r" & sleep 0.2;\
		php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" >> /dev/null 2>&1;\
		printf "${WORKING} Installing ${LIGHTPURPLE}Composer${NOCOLOR} █____\r" & sleep 0.2;\
		php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" >> /dev/null 2>&1\
		printf "${WORKING} Installing ${LIGHTPURPLE}Composer${NOCOLOR} ██___\r" & sleep 0.2;\
		php composer-setup.php >> /dev/null 2>&1;\
		printf "${WORKING} Installing ${LIGHTPURPLE}Composer${NOCOLOR} ███__\r" & sleep 0.2;\
		php -r "unlink('composer-setup.php');" >> /dev/null 2>&1;\
		printf "${WORKING} Installing ${LIGHTPURPLE}Composer${NOCOLOR} ████_\r" & sleep 0.2;\
		sudo mv composer.phar /usr/local/bin/composer;\
		printf "${WORKING} Installing ${LIGHTPURPLE}Composer${NOCOLOR} █████\r" & sleep 0.2;\
		echo "${CHECKMARK} Installing ${LIGHTPURPLE}Composer${NOCOLOR} ${OK}";\
	fi

vscode: #1# Install Visual Studio Code
	@if which code >/dev/null; then \
		echo "${CHECKMARK} ${LIGHTPURPLE}Visual Studio Code${NOCOLOR} is already installed"; \
	else \
		printf "${WORKING} Installing ${LIGHTPURPLE}VSCode${NOCOLOR}..\r";\
		(sudo snap install --classic code) >> /dev/null 2>&1; \
		if [ $$? -eq 0 ]; then \
			echo  "${CHECKMARK} Installing ${LIGHTPURPLE}VSCode${NOCOLOR} ${OK}";\
		else \
			echo  "${CROSS} Installing ${LIGHTPURPLE}VSCode${NOCOLOR} ${KO}";\
		fi;\
	fi;
	@make -s vscode-settings;
	@make -s vscode-extensions;

chrome: #1# Install Google Chrome web browser
	if which google-chrome-stable >/dev/null; then\
		echo "${CHECKMARK} ${LIGHTPURPLE}Google Chrome${NOCOLOR} is already installed"; \
	else \
		printf "${WORKING} Installing ${LIGHTPURPLE}Google Chrome${NOCOLOR}..\r";\
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb >> /dev/null 2>&1;\
		sudo dpkg -i ./google-chrome-stable_current_amd64.deb >> /dev/null 2>&1;\
		if [ $$? -eq 0 ]; then \
			(sudo rm ./google-chrome-stable_current_amd64.deb) ;\
			echo  "${CHECKMARK} Installing ${LIGHTPURPLE}Google Chrome${NOCOLOR} ${OK}";\
		else \
			echo  "${CROSS} Installing ${LIGHTPURPLE}Google Chrome${NOCOLOR} ${KO}";\
		fi;\
	fi

slack: #1# Install Slack
	@if which slack >/dev/null; then\
		echo "${CHECKMARK} ${LIGHTPURPLE}Slack${NOCOLOR} is already installed"; \
	else \
		printf "${WORKING} Installing ${LIGHTPURPLE}Slack${NOCOLOR}..\r";\
		wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.19.2-amd64.deb >> /dev/null 2>&1;\
		sudo dpkg -i ./slack-desktop-4.19.2-amd64.deb >> /dev/null 2>&1;\
		if [ $$? -eq 0 ]; then \
			(sudo rm ./slack-desktop-4.19.2-amd64.deb.deb) ;\
			echo  "${CHECKMARK} Installing ${LIGHTPURPLE}Slack${NOCOLOR} ${OK}";\
		else \
			echo  "${CROSS} Installing ${LIGHTPURPLE}Slack${NOCOLOR} ${KO}";\
		fi;\
	fi

postman: #1# Install Postman
	@if which postman >/dev/null; then \
		echo "${CHECKMARK} ${LIGHTPURPLE}Postman${NOCOLOR} is already installed"; \
	else \
		printf "${WORKING} Installing ${LIGHTPURPLE}Postman${NOCOLOR}..\r";\
		(sudo snap install postman  >> /dev/null 2>&1);\
		if [ $$? -eq 0 ]; then \
			echo "${CHECKMARK} Installing ${LIGHTPURPLE}Postman${NOCOLOR} ${OK}";\
		else \
			echo "${CROSS} Installing ${LIGHTPURPLE}Postman${NOCOLOR} ${KO}";\
		fi;\
	fi

docker: #1# Install Docker
	@if which docker >/dev/null; then \
		echo "${CHECKMARK} ${LIGHTPURPLE}Docker${NOCOLOR} is already installed"; \
	else \
		printf "${WORKING} Installing ${LIGHTPURPLE}Docker${NOCOLOR}..\r";\
		sudo sh ./Assets/get-docker.sh >> /dev/null 2>&1;\
		if [ $$? -eq 0 ]; then \
			echo  "${CHECKMARK} Installing ${LIGHTPURPLE}Docker${NOCOLOR} ${OK}";\
		else \
			echo  "${CROSS} Installing ${LIGHTPURPLE}Docker${NOCOLOR} ${KO}";\
		fi;\
		sudo groupadd docker >> /dev/null 2>&1;\
		sudo usermod -aG docker $$USER >> /dev/null 2>&1;\
		sudo chown "$$USER":"$$USER" /home/"$$USER"/.docker -R >> /dev/null 2>&1;\
		sudo chmod g+rwx "$$HOME/.docker" -R >> /dev/null 2>&1;\
		sudo systemctl start docker >> /dev/null 2>&1;\
		sudo systemctl enable docker.service >> /dev/null 2>&1;\
		sudo systemctl enable containerd.service >> /dev/null 2>&1;\
	fi
	@make -s docker-desktop;

docker-desktop:
	@printf "${WORKING} Installing Docker Desktop..\r";\
	if 	ls /usr/share/applications | grep "docker-desktop"  >> /dev/null 2>&1; then \
		echo "${CHECKMARK} ${LIGHTPURPLE}Docker Desktop${NOCOLOR} is already installed"; \
	else \
		if 	! ls ./Assets/ | grep 'docker-desktop-4.19.0-amd64.deb' >> /dev/null 2>&1; then \
			wget -O ./Assets/docker-desktop-4.19.0-amd64.deb "https://desktop.docker.com/linux/main/amd64/docker-desktop-4.19.0-amd64.deb?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-linux-amd64" >> /dev/null 2>&1;\
		fi; \
		sudo apt install -yq ./Assets/docker-desktop-4.19.0-amd64.deb >> /dev/null 2>&1;\
		if [ $$? -eq 0 ]; then \
			echo  "${CHECKMARK} Installing ${LIGHTPURPLE}Docker Desktop${NOCOLOR} ${OK}";\
			sudo rm ./Assets/docker-desktop-4.19.0-amd64.deb >> /dev/null 2>&1;\
		else \
			echo  "${CROSS} Installing ${LIGHTPURPLE}Docker Desktop${NOCOLOR} ${KO}";\
		fi;\
	fi

vscode-settings:
	@if [ ! -f /home/$$USER/.config/Code/User/settings.json >> /dev/null 2>&1 ]; then \
		mkdir -p /home/$$USER/.config/Code ;\
		mkdir -p /home/$$USER/.config/Code/User ;\
		touch /home/$$USER/.config/Code/User/settings.json ;\
	fi;\
	if cat /home/$$USER/.config/Code/User/settings.json | grep "// My Settings" >> /dev/null 2>&1; then \
		echo "${CHECKMARK} ${LIGHTPURPLE}VS Code settings${NOCOLOR} are already installed"; \
	else \
		rm /home/$$USER/.config/Code/User/settings.json; \
		cp ./Assets/settings.json /home/$$USER/.config/Code/User/settings.json;\
		echo  "${CHECKMARK} Copied ${LIGHTPURPLE}VSCode settings.json${NOCOLOR} ${OK}";\
	fi;\


vscode-extensions:

	@printf "${WORKING} Installing ${LIGHTPURPLE}VS Code extensions${NOCOLOR} ";\
	$(foreach val,${VSCODEXT}, \
        if code --list-extensions | grep "$(val)" >/dev/null; then \
			printf ".";\
		else \
			code --install-extension $(val) >> /dev/null 2>&1;\
			printf "+";\
		fi;\
    )\
	printf ".\r";\
	echo  "${CHECKMARK} Installing ${LIGHTPURPLE}VS Code extensions${NOCOLOR} ${OK}               ";\

vscode-purge:
	code --list-extensions | xargs -L 1 code --uninstall-extension;
	rm /home/$$USER/.config/Code/User/settings.json;
	touch /home/$$USER/.config/Code/User/settings.json;

aliases:
	@if cat ~/.bashrc | grep "#My own aliases!" >/dev/null; then \
		echo "${CHECKMARK} ${LIGHTPURPLE}Command aliases${NOCOLOR} are already installed"; \
	else \
		echo "#My own aliases!" >> ~/.bashrc ; \
		echo "alias dc='docker'" >> ~/.bashrc ; \
		echo "alias dcc='dc compose'" >> ~/.bashrc ; \
		echo "alias dce='dc exec -ti'" >> ~/.bashrc ; \
		echo "alias dcstop='dc stop \$(dc ps -aq)'" >> ~/.bashrc ; \
		echo  "${CHECKMARK} ${LIGHTPURPLE}Command aliases${NOCOLOR} being copied in ~/.bashrc ${OK}"; \
	fi

shortcuts:
	dconf write /org/gnome/shell/favorite-apps "['org.gnome.Calculator.desktop', 'gnome-control-center.desktop', 'code_code.desktop', 'slack.desktop', 'docker-desktop.desktop', 'google-chrome.desktop', 'postman_postman.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop']";

header:
	@echo '';\
	echo '${HEADER}                                                                              ${NOCOLOR}';\
    echo '${HEADER}       ▒▒▒▒▒▒▒▒▒▒                                                             ${NOCOLOR}';\
    echo '${HEADER}     ▒▒▒▒▒▒▒▒▒▒▒▒▒▒     ${HEADERTITLE}Starter pack installer for Ubuntu 22.04 LTS${NOCOLOR}${HEADER}           ${NOCOLOR}';\
    echo '${HEADER}   ▒▒▒▒██▒▒▒▒▒▒██▒▒▒▒                                                         ${NOCOLOR}';\
    echo '${HEADER}   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ${HEADERCOMMENT}> Assuming you freshly installed Ubuntu                 ${NOCOLOR}';\
    echo '${HEADER}   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒      ${HEADERCOMMENT}This collection of command will take care of the   ${NOCOLOR}';\
    echo '${HEADER}     ▒▒▒▒▒▒▒▒▒▒▒▒▒▒        ${HEADERCOMMENT}PHP developpers basic tools installation           ${NOCOLOR}';\
    echo '${HEADER}     ▒▒  ▒▒  ▒▒  ▒▒                                                           ${NOCOLOR}';\
    echo '${HEADER}   ▒▒▒▒  ▒▒  ▒▒  ▒▒   ${HEADERCOMMENT}> Below is a list of all commands, each one installs    ${NOCOLOR}';\
    echo '${HEADER}   ▒▒  ▒▒  ▒▒  ▒▒  ▒▒     ${HEADERCOMMENT}one tool, for example \033[1;35mmake chrome${NOCOLOR}${HEADERCOMMENT} will get you      ${NOCOLOR}';\
    echo '${HEADER}   ▒▒  ▒▒  ▒▒  ▒▒  ▒▒     ${HEADERCOMMENT}Google chrome web browser                           ${NOCOLOR}';\
    echo '${HEADER}     ▒▒  ▒▒▒▒▒▒  ▒▒                                                           ${NOCOLOR}';\
    echo '${HEADER}     ▒▒  ▒▒  ▒▒  ▒▒   ${HEADERCOMMENT}> \033[1;35mmake all${NOCOLOR}${HEADERCOMMENT} will install all tools from top to bottom    ${NOCOLOR}';\
	echo '${HEADER}                                                                              ${NOCOLOR}';\
	echo '';



success:
	@echo '';\
	echo '${UBUNTU}                                                      ${NOCOLOR}';\
	echo '${UBUNTU}   \033[1;42m OK ${UBUNTU} Installation successful                       ${NOCOLOR}';\
	echo '${UBUNTU}                                                      ${NOCOLOR}';\
	echo '${UBUNTU}   The final step is to reboot your computer          ${NOCOLOR}';\
	echo '${UBUNTU}   in order to run \033[1;94mDocker${UBUNTU} without sudo                ${NOCOLOR}';\
	echo '${UBUNTU}                                                      ${NOCOLOR}';\
	echo '${UBUNTU}    Check your aliases as well                        ${NOCOLOR}';\
	echo '${UBUNTU}                                                      ${NOCOLOR}';\
	echo '${UBUNTU}    Then you are go to go !                           ${NOCOLOR}';\
	echo '${UBUNTU}                                                      ${NOCOLOR}';\
	echo '';


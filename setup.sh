#!/usr/bin/env bash

fullinstallation="false";
if [[ $1 = "-f" ]] || [[ $1 = "--full" ]]; then
    fullinstallation="true";
    echo "Full installation selected."
elif [[ $2 = "-f" ]] || [[ $2 = "--full" ]]; then
    fullinstallation="true";
    echo "Full installation selected."
else
    echo "Lite installation will proceed by default."
fi

cronupdates="false";
if [[ $1 = "-u" ]] || [[ $1 = "--updates" ]]; then
    cronupdates="true";
    echo "Weekly updates selected."
elif [[ $2 = "-u" ]] || [[ $2 = "--updates" ]]; then
    cronupdates="true";
    echo "Weekly updates selected."
else
    echo "Weekly updates are disabled by default."
fi

sudo apt dist-upgrade -y
sudo apt update -y
sudo apt upgrade -y

#install pip
sudo apt install -y python-pip
sudo apt install -y python3-pip
sudo pip install --upgrade pip

#a bunch of "essentials" for python3
sudo apt install -y python3 python-dev python3-dev build-essential libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev
sudo python3 -m pip install setuptools wheel
#install Spyder
sudo apt install -y spyder
sudo apt install -y spyder3

#install G++
sudo apt install -y g++

# install cmake
sudo apt install -y cmake

#install git
sudo apt install -y git
git config --global user.name "alexandermichels"
git config --global user.email alexandercm4297@gmail.com
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# mailutils
sudo apt install -y mailutils

#install spotify
sudo apt install -y spotify-client

#install Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update -y
sudo apt install -y google-chrome-stable

#install curl
sudo apt install -y curl

#install VLC
sudo sudo apt dist-upgrade -ypository ppa:videolan/stable-daily
sudo apt update -y
sudo apt install -y vlc

#install deluge
sudo apt install -y deluge


if [ $fullinstallation == "true" ]; then
    # htop
    sudo apt install -y htop

    # pytest and matplotlib
    sudo apt install -y python-pytest
    sudo apt install -y python-matplotlib
    sudo apt install -y python3-matplotlib

    # OpenGL API, Mesa Off-screen rendering extension, and other fun stuff for [mujoco-py](https://github.com/openai/mujoco-py#install-mujoco)
    sudo apt install -y libosmesa6-dev libgl1-mesa-dev libopenmpi-dev patchelf

    # VirtualEnv
    sudo pip install virtualenv
    # Atom
    sudo add-apt-repository -y ppa:webupd8team/atom
    sudo apt update -y
    sudo apt install -y atom

    # install MiKTeX
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889
    echo "deb [arch=amd64] http://miktex.org/download/ubuntu bionic universe" | sudo tee /etc/apt/sources.list.d/miktex.list
    sudo apt update -y
    sudo apt install -y miktex
    sudo miktexsetup --shared=yes finish
    sudo initexmf --admin --set-config-value [MPM]AutoInstall=1
    sudo apt install -y -y texlive-latex-extra
    sudo mpm --admin --verbose --package-level=complete --upgrade

    # install texstudio
    sudo apt install -y texstudio

    # install JDK
    sudo echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | tee -a     /etc/apt/sources.list
    sudo echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | tee -a /etc/apt/sources.list
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
    sudo apt update -y
    sudo apt install -y oracle-java8-installer
    sudo apt install -y oracle-java8-set-default
    #add .desktop file

    #Gradle
    sudo add-apt-repository -y ppa:cwchien/gradle
    sudo apt update -y
    sudo apt upgrade -y gradle

    #Maven
    sudo apt install -y maven

    #Grip
    sudo pip install grip

    #install R
    sudo apt install -y r-base-code
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/"  | sudo tee -a /etc/apt/sources.list
    sudo apt update -y
    sudo apt install -y r-base r-base-dev r-recommended r-doc-html r-doc-pdf ess
    sudo R -e 'install.packages("mosaic", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("rmarkdown", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("Lock5Data", repos="http://cran.us.r-project.org")'
    sudo R -e 'install.packages("ggformula", repos="http://cran.us.r-project.org")'

    #install RStudio
    #sudo apt install -y
    #R studio is being odd, I'm looking into it

fi

if [ $cronupdates == "true" ]; then
    sudo apt install -y cron-apt
    sudo rm /etc/cron.d/cron-apt
    sudo ln -s /usr/sbin/cron-apt /etc/cron.weekly/
    sudo mv autoupdate.sh /etc/cron.weekly/
    sudo chmod +x /etc/cron.weekly/autoupdate.sh
fi

sudo apt dist-upgrade -y
sudo apt update -y
sudo apt upgrade -y

#Clean
sudo apt -y remove pidgin
sudo apt -y remove hexchat
sudo apt -y remove transmission-gtk
sudo apt -y remove rhythmbox
sudo apt -y remove mopidy
sudo apt -y remove xplayer
sudo apt purge -y pidgin
sudo apt purge -y hexchat
sudo apt purge -y transmission-gtk
sudo apt purge -y rhythmbox
sudo apt purge -y mopidy
sudo apt purge -y xplayer

sudo apt autoremove -y
sudo apt clean -y all
rm -rf ~/.cache/thumbnails/*
sudo du -sh /var/cache/apt 

sudo apt update -y
sudo apt upgrade -y

#!/bin/bash
if [  "$(python3.6 -V)" = "Python 3.6.2" ]; then
 echo "######### python3.6 is available#########"
else
 echo "##########################################"
 echo "Python3.6 is not installed on your system ."
 echo "##########################################"
 echo "######## Installing Python3.6 ############"
 echo "####### It will take some time ###########"
 sudo apt-get update
 sudo apt-get install -y gcc
 sudo apt-get install -y build-essential checkinstall
 sudo apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
 cd /usr/src
 sudo wget https://www.python.org/ftp/python/3.6.2/Python-3.6.2.tgz
 sudo tar xzf Python-3.6.2.tgz
 cd Python-3.6.2
 sudo ./configure
 sudo make altinstall
 cd
 echo "############ Changing python version #####"
 sudo echo "alias python=python3.6" >> sudo .bashrc
 sudo echo "alias pip=pip3.6" >> sudo .bashrc
 echo "######### installing Virtualenv ###########"
 sudo apt-get install -y virtualenv
fi

if [ -d "python3" ]; then
 source python3/bin/activate
else
 virtualenv python3 --python=python3.6
 source python3/bin/activate
fi
cd ~/project/report-analysis
pip3.6 install -r requirements.txt
ipaddress= `ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`
FLASK_APP=hello.py flask run --host=$ipaddress


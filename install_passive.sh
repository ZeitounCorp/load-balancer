#!/usr/bin/env bash
#
# Auto Install script for the zombie api
#

{ # this ensures the entire script is downloaded #

# Defining colors for echo outputs
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
# End defining colors

bash_has() {
  type "$1" > /dev/null 2>&1
}

echo -e "${YELLOW}=> Beginning installation of the zombie api${NC}"

checkIfNodeInstalled() {
  echo -e "${YELLOW}=> Check if node is installed on the system${NC}"
  if bash_has "node"; then
    echo -e "${GREEN}-> Node is installed, skipping...${NC}"
    install_api
  else
    echo -e "${RED}-> Node is not installed,${NC} ${GREEN}installing NodeJs via NVM(https://github.com/nvm-sh/nvm)${NC}"
    installNVM
  fi
}

installNVM() {
  if bash_has "curl"; then
    echo -e "${GREEN}-> Downloading NVM through curl.${NC}"
    command curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
    installNode
  else
    echo -e "${GREEN}-> Downloading NVM through curl.${NC}"
    command wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | bash
    installNode
  fi
}

installNode() {
  if command -v nvm; then
    echo -e "${YELLOW}-> Installing Node@14.15.1 and NPM@6.14.8.${NC}"
    nvm install 14.15.1
    nvm use node
    echo -e "${GREEN}-> Node@14.15.1 and NPM@6.14.8. have been installed${NC}\n"
    echo -e "${YELLOW}-> Now Installing the API from GitHub(https://github.com/ZeitounCorp/load-balancer-bbb-zombie)${NC}"
    install_api
  else 
    echo -e "${BLUE}-> Installing Node@14.15.1 and NPM@6.14.8.${NC}"
    exportNVM
    nvm install 14.15.1
    nvm use node
    echo -e "${BLUE}-> Node@14.15.1 and NPM@6.14.8. have been installed${NC}\n"
    echo -e "${YELLOW}-> Now Installing the API from GitHub(https://github.com/ZeitounCorp/load-balancer-bbb-zombie)${NC}"
    install_api
  fi
}

exportNVM() {
  command curl -o export_nvm.sh https://raw.githubusercontent.com/ZeitounCorp/load-balancer/master/export_nvm.sh
  command chmod u+x ~/export_nvm.sh
  source ~/export_nvm.sh
}

install_api() {
  if bash_has "git"; then
    echo -e "${YELLOW}-> Cloning now the api at ~/load-balancer-bbb-zombie${NC}"
    command git clone https://github.com/ZeitounCorp/load-balancer-bbb-zombie.git
  else
    echo -e "${YELLOW}-> We first need to install Git.${NC}\n"
    command sudo apt install git-all
    echo -e "${BLUE}-> Git is now installed, cloning now the api at ~/load-balancer-bbb-zombie.${NC}\n"
    command git clone https://github.com/ZeitounCorp/load-balancer-bbb-zombie.git 
  fi
  echo -e "${GREEN}-> Api is now installed at ~/load-balancer-bbb-zombie${NC}\n"
  echo -e "${YELLOW}-> Now we need to install PM2 (It's a process manager to run node instance in the background)${NC}\n"
  command sudo npm install pm2 -g
  echo -e "${GREEN}-> PM2 is now installed, now configuring the server to accept incomming request${NC}\n"
  echo -e "${YELLOW}-> Now launching the app on port 3001:${NC}\n"
  pm2START
}

pm2START() {
  command cd ~/load-balancer-bbb-zombie
  command pm2 start server_bbb.js
  echo -e "${GREEN}-> App is now running on port 3001:${NC}\n"
}

main() {
  checkIfNodeInstalled
}

# Running the Script
main

} # this ensures the entire script is downloaded #

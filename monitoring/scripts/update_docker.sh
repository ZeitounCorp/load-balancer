
#!/usr/bin/env bash
#
# Auto Update script for the docker engine
#
{ # this ensures the entire script is downloaded #

# Defining colors for echo outputs
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
# End defining colors

echo -e "${YELLOW}=> Beginning the update of docker engine${NC}"

removeOld() {
  echo -e "${YELLOW}=> Removing old versions installed of docker${NC}"
  sudo apt-get remove docker docker-engine docker.io containerd runc
  fetchingRepository
}

fetchingRepository() {
  echo -e "${YELLOW}=> Now fetching the repository for docker installation${NC}"
  sudo apt-get update
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
  addingKey
}

addingKey() {
  echo -e "${YELLOW}=> Fetching the official docker gpg key${NC}"
  command curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  installDocker
}

# comparingKey() {
#    sudo apt-key fingerprint 0EBFCD88
#    echo -e "${YELLOW}=> Does the key 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88 correspond to the one in pub ? [y / n]${NC} "
#    while read -r response; 
#    do 
#      if [[ $response == y* ]]; then
#       echo -e "${GREEN}-> Great now installing Docker via official repository${NC}"
#       installDocker
#      elif [[ $response == n* ]]; then  
#       echo -e "${RED}-> Operation stopped exit 0${NC}"
#       exit 0
#      else
#       echo -e "${RED}-> We are waiting for input to be y or n${NC}"
#      fi   
#    done 
# }

installDocker() {
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   sudo apt-get update
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io
   echo -e "${GREEN}-> You are all set docker has been successfully install on this machine${NC}"
}

main() {
  removeOld
}

# Running the Script
main

} # this ensures the entire script is downloaded #

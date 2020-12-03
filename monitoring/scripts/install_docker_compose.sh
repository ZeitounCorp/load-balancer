
#!/usr/bin/env bash
#
# Auto Install script for the installation od docker-compose
#
{ # this ensures the entire script is downloaded #

# Defining colors for echo outputs
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
# End defining colors

bash_has() {
  type "$1" > /dev/null 2>&1
}

echo -e "${YELLOW}=> Beginning installation of docker-compose${NC}"

main() {
  sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  if bash_has "docker-compose"; then
    sudo chmod +x /usr/local/bin/docker-compose
    echo -e "${GREEN}-> Docker-Compose has been successfully install on the machine${NC}"
  else
    echo -e "${RED}-> A problem occured while trying to find docker-compose, try again${NC}"
  fi
}

# Running the Script
main

} # this ensures the entire script is downloaded #

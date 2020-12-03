## bigbluebutton_monitoring
This repository comes from the main project [/ZeitounCorp/load-balancer/monitoring](https://github.com/ZeitounCorp/load-balancer)

## PORTS REQUIRED TO BE "OPEN"
- __5556__ in order to serve the Dashboard
- __9688__ in order for prometheus to scrape the big blue button api
- __9100__ in order for prometheus to scrape the instance's ressource usgae

## How to install | Update ?
- ### Auto-Update script for Docker
  - ```curl -o- https://raw.githubusercontent.com/ZeitounCorp/bigbluebutton_monitoring/main/scripts/update_docker.sh | bash```

- ### Auto-Install script for Docker-Compose
  - ```curl -o- https://raw.githubusercontent.com/ZeitounCorp/bigbluebutton_monitoring/main/scripts/install_docker_compose.sh | bash```

- ### Install the monitoring system
  - ```cd ~ && git clone https://github.com/ZeitounCorp/bigbluebutton_monitoring.git``` 
  - Next you need to ```cd ~/bigbluebutton_monitoring/bbb-exporter/```
  - Get your BBB secret by running: ```sudo bbb-conf --secret```
  - Then replace __API_BASE_URL__ and __API_SECRET__ in ```./bbb_exporter_secrets.env``` with the data received from ```--secret``` ⚠️ Don't forget to append ```/api/``` to the __URL__ returned from ```--secret``` ⚠️
  - Replace __GF_SERVER_ROOT_URL__ value in ```./docker-compose.yaml``` by ```https://YOUR_HOSTNAME/monitoring```
  - Run ```sudo docker-compose up -d```
  - Then you need to configure __NginX__:
    - ```cd /etc/bigbluebutton/nginx/```
    - ```sudo nano ./monitoring.nginx```
    - Copy/Paste the following: 
    ```
    # BigBlueButton monitoring
    location /monitoring/ {
      proxy_pass http://127.0.0.1:5556/;
      include proxy_params;
    }
    ```
    - Save and Exit
    - Test NginX with ```sudo nginx -t```
    - If no error then, execute ```sudo systemctl daemon-reload```
    - Execute ```sudo systemctl reload nginx```

### If everything was done correctly, you should now be able to access Grafana @ ```https://YOUR_HOSTNAME/monitoring```

## Next Steps
- Concerning configuring Grafana follow the guide I've written: [Configuring Grafana](https://github.com/ZeitounCorp/bigbluebutton_monitoring/tree/main/grafana)

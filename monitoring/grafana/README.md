## Grafana

- Login to Grafana (https://HOSTNAME/monitoring) in your web browser (admin:admin) and change the password.

- Add Prometheus as a data source (Configuration -> Add data source -> Prometheus) and entering the following configuration and under HTTP set:

```URL: http://localhost:9090```

## Set the Dashboard

- Create a new dashboard (Create -> Import) and then copy/paste the content of ```/dashboards/server_instance_node_exporter.json``` into ```Import via panel json```
- Click ```Load```

## Small changes to do on the newly created dashboard

- Set ```Datasource``` to ```default```
- Set ```Job``` to ```bbb```
- Set ```Job node_exporter``` to ```bbb_node_exporter```
- Set ```Instance``` to ```localhost```

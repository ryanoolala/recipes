template:
	@helm template grafana stable/grafana -f ./values.yaml --namespace grafana  > ../install.yaml

install:
	@helm install grafana stable/grafana -f ./values.yaml --create-namespace --namespace grafana

install.datasource:
	@helm install grafana stable/grafana -f ./values.yaml -f ./datasource.yaml --create-namespace --namespace grafana

upgrade:
	@helm upgrade grafana stable/grafana -f ./values.yaml --namespace grafana

upgrade.datasource:
	@helm upgrade grafana stable/grafana -f ./values.yaml -f ./datasource.yaml --namespace grafana
template:
	@helm template grafana stable/grafana -f ./values.yaml --namespace grafana  > ../install.yaml

install:
	@helm install grafana stable/grafana -f ./values.yaml --create-namespace --namespace grafana

upgrade:
	@helm upgrade grafana stable/grafana -f ./values.yaml --namespace grafana

template:
	@helm template prometheus stable/prometheus -f ./values.yaml --namespace prometheus  > ../install.yaml

install:
	@helm install prometheus stable/prometheus -f ./values.yaml --create-namespace --namespace prometheus

upgrade:
	@helm upgrade prometheus stable/prometheus -f ./values.yaml --namespace prometheus

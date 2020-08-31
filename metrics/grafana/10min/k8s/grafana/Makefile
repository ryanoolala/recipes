RELEASE_NAME=grafana-ha
NAMESPACE=grafana

template:
	@helm template $(RELEASE_NAME) stable/grafana -f ./values.yaml --namespace $(NAMESPACE) > ../install.yaml

install:
	@helm install $(RELEASE_NAME) stable/grafana -f ./values.yaml --create-namespace --namespace $(NAMESPACE)

uninstall:
	@helm uninstall $(RELEASE_NAME) --namespace $(NAMESPACE)

upgrade:
	@helm upgrade $(RELEASE_NAME) stable/grafana -f ./values.yaml --namespace $(NAMESPACE)

secret:
	@printf -- "Removing old grafana-db-connection...\n"
	@kubectl delete secret --namespace grafana grafana-db-connection || true
	@echo "Postgres Host?: "; \
		read HOST; \
	echo "Postgres Username?: "; \
		read USERNAME; \
	echo "Postgres Password? (keys will not show up in the terminal): "; \
		read -s PASSWORD; \
	printf -- "Attempted to create secret 'grafana-db-connection'...\n"; \
	kubectl create secret generic --namespace grafana grafana-db-connection \
		--from-literal=GF_DATABASE_USER=$$USERNAME \
		--from-literal=GF_DATABASE_PASSWORD=$$PASSWORD \
		--from-literal=GF_DATABASE_HOST=$$HOST
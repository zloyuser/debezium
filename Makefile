#!make

mysql_cli = docker compose exec mysql mysql -uroot -pdebezium -Dinventory
materialize_cli = docker run --name materialized-cli --network internal --rm -it materialize/cli
connect_curl = docker compose exec connect curl -XPOST -H "Accept:application/json" -H "Content-Type:application/json" "http://localhost:8083/connectors"
elastic_curl = docker compose exec elastic curl -XGET -H "Accept:application/json" -H "Content-Type:application/json"

help: ## Show this help
	@printf "\033[33m%s:\033[0m\n" 'Run: make <target> where <target> is one of the following'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[32m%-18s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

up: ## Setup required containers
	docker compose up -d

mysql: ## Run MySQL client
	$(mysql_cli)

mysql_customers: ## Show customers in MySQL
	$(mysql_cli) -e "select * from customers"

mysql_addresses: ## Show addresses in MySQL
	$(mysql_cli) -e "select * from addresses"

materialize: ## Run materialized client
	$(materialize_cli)

materialize_sources: ## Configure Materialized sources
	$(materialize_cli) -c "$(shell cat ./etc/materialized/00.source.customers.sql)"
	$(materialize_cli) -c "$(shell cat ./etc/materialized/00.source.addresses.sql)"

materialize_views: ## Configure Materialized views
	$(materialize_cli) -c "$(shell cat ./etc/materialized/10.views.sql)"

materialize_sinks: ## Configure Materialized sinks
	$(materialize_cli) -c "$(shell cat ./etc/materialized/20.sinks.sql)"

sink_database: ## Configure MYSQL connector to Kafka
	$(connect_curl) --data-raw '$(subst \\n,,$(shell cat ./etc/connect/sink_database.json))'

sink_customers: ## Configure ElasticSearch connector from Kafka customers
	$(connect_curl) --data-raw '$(subst \\n,,$(shell cat ./etc/connect/sink_customers.json))'

sink_addresses: ## Configure ElasticSearch connector from Kafka addresses
	$(connect_curl) --data-raw '$(subst \\n,,$(shell cat ./etc/connect/sink_addresses.json))'

elastic_customers: ## Show customers in ElasticSearch
	$(elastic_curl) "http://localhost:9200/dbserver1.inventory.customers/_search?pretty"

elastic_addresses: ## Show addresses in ElasticSearch
	$(elastic_curl) "http://localhost:9200/dbserver1.inventory.customer_addresses/_search?pretty"

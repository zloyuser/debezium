# Debezium Playground

## Prerequisites

[Debezium CDC configuration for MySQL](https://debezium.io/documentation/reference/stable/connectors/mysql.html#setting-up-mysql)

## Setup

```shell
make up
```

## Usage

Use Makefile, Luke :)

### Primary targets

| Target                | Description                                            |
|-----------------------|--------------------------------------------------------|
| `sink_database`       | Configure MYSQL connector to Kafka                     |
| `materialize_sources` | Configure Materialize sources from Kafka               |
| `materialize_views`   | Configure Materialize views from sources               |
| `materialize_sinks`   | Configure Materialize sinks to Kafka                   |
| `sink_customers`      | Configure ElasticSearch connector from Kafka customers |
| `sink_addresses`      | Configure ElasticSearch connector from Kafka addresses |

### Additional targets

| Target              | Description                     |
|---------------------|---------------------------------|
| `mysql`             | Run MySQL client                |
| `mysql_customers`   | Show customers in MySQL         |
| `mysql_addresses`   | Show addresses in MySQL         |
| `elastic_customers` | Show customers in ElasticSearch |
| `elastic_addresses` | Show addresses in ElasticSearch |
| `materialize`       | Run Materialize client          |

## Documentation

[RedPanda](https://docs.redpanda.com)

[Kafka](https://kafka.apache.org/documentation)

[Kafka Connect](https://kafka.apache.org/documentation#connect)

[Materialize](https://materialize.com/docs)

CREATE SOURCE customers FROM KAFKA BROKER 'redpanda:29092' TOPIC 'dbserver1.inventory.customers'
FORMAT AVRO USING CONFLUENT SCHEMA REGISTRY 'http://redpanda:8081' ENVELOPE DEBEZIUM;

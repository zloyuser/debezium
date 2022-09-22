CREATE SINK customer_addresses_sink FROM customer_addresses
INTO KAFKA BROKER 'redpanda:29092' TOPIC 'dbserver1.inventory.customer_addresses' KEY (id)
CONSISTENCY (TOPIC 'consistency.customer_addresses' FORMAT AVRO USING CONFLUENT SCHEMA REGISTRY 'http://redpanda:8081')
WITH (reuse_topic=true)
FORMAT AVRO USING CONFLUENT SCHEMA REGISTRY 'http://redpanda:8081';

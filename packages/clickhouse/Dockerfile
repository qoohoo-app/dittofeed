FROM clickhouse/clickhouse-server:23.8.8.20-alpine

# Create the directories on the docker volume to emulate multiple volumes
RUN mkdir -p /data/clickhouse_lib
RUN mkdir -p /data/clickhouse_log

# Symlink volume to directories
RUN ln -s /data/clickhouse_lib /var/lib/clickhouse_lib
RUN ln -s /data/clickhouse_log /var/log/clickhouse_log

EXPOSE 8123 9000 9009
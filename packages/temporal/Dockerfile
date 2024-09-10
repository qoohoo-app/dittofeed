FROM temporalio/ui:2.30.2 as ui

WORKDIR /etc/temporal

FROM temporalio/auto-setup:1.25.0.0 as final

COPY --from=ui --chown=temporal:temporal /home/ui-server /home/ui-server
RUN rm -rf /home/ui-server/config/*

ENV BIND_ON_IP=0.0.0.0
ENV TEMPORAL_BROADCAST_ADDRESS=0.0.0.0

EXPOSE 7233 8080

ENV DYNAMIC_CONFIG_FILE_PATH=/etc/temporal/config/dynamicconfig/docker.yaml

COPY --chmod=755 ./scripts/start-ui.sh /etc/temporal/start-ui.sh
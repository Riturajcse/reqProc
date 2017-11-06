FROM {{%DRYDOCK_ORG%}}/microbase:{{%TAG%}}

ENV REQPROC_PATH /home/shippable/reqProc
ADD . $REQPROC_PATH
RUN cd $REQPROC_PATH && npm install

ENV EXEC_TEMPLATES_PATH /home/shippable/execTemplates
RUN mkdir -p $EXEC_TEMPLATES_PATH && \
    wget https://github.com/Shippable/execTemplates/archive/{{%TAG%}}.tar.gz -O /tmp/execTemplates.tar.gz && \
    tar -xzvf /tmp/execTemplates.tar.gz -C $EXEC_TEMPLATES_PATH --strip-components=1 && \
    rm /tmp/execTemplates.tar.gz

ENV REQEXEC_PATH /home/shippable/reqExec
RUN mkdir -p $REQEXEC_PATH && \
    wget https://s3.amazonaws.com/shippable-artifacts/reqExec/{{%TAG%}}/reqExec-{{%TAG%}}-{{%ARCHITECTURE%}}-{{%OS%}}.tar.gz -O /tmp/reqExec.tar.gz && \
    tar -xzvf /tmp/reqExec.tar.gz -C $REQEXEC_PATH && \
    rm /tmp/reqExec.tar.gz

ENTRYPOINT ["/home/shippable/reqProc/boot.sh"]

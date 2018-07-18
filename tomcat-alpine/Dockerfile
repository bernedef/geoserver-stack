FROM java-alpine

ENV TOMCAT_VERSION=8.5.31 \
    TOMCAT_VERSION_MAJOR=8 \
    TOMCAT_APR_VERSION=1.6.3 \
    TOMCAT_APR_ICONV_VERSION=1.2.2 \
    TOMCAT_NATIVE_VERSION=1.2.16

# tomcat

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=${CATALINA_HOME}/bin:${PATH}

RUN mkdir -p ${CATALINA_HOME} && \
    wget http://apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O- | tar -xzC ${CATALINA_HOME} --strip-components=1 && \
    cd ${CATALINA_HOME} && rm -r bin/*.bat webapps/ROOT webapps/manager webapps/host-manager webapps/docs webapps/examples && \
    sed -i'' 's/<Connector/<Connector URIEncoding="UTF-8"/g' ${CATALINA_HOME}/conf/server.xml

# tomcat apr

RUN apk --no-cache add -t .build-deps build-base && \
    wget http://apache.org/dist/apr/apr-${TOMCAT_APR_VERSION}.tar.gz -O- | tar -xzC /tmp && \
    cd /tmp/apr-${TOMCAT_APR_VERSION} && \
    touch libtoolT && ./configure --prefix=/usr/local --enable-nonportable-atomics --with-devrandom=/dev/urandom && make && make install && \
    rm -r /tmp/apr-${TOMCAT_APR_VERSION} && \
    apk del .build-deps

# tomcat apr-iconv

RUN apk --no-cache add -t .build-deps build-base && \
    wget http://apache.org/dist/apr/apr-iconv-${TOMCAT_APR_ICONV_VERSION}.tar.gz -O- | tar -xzC /tmp && \
    cd /tmp/apr-iconv-${TOMCAT_APR_ICONV_VERSION} && \
    touch libtoolT && ./configure --prefix=/usr/local --with-apr=/usr/local && make && make install && \
    rm -r /tmp/apr-iconv-${TOMCAT_APR_ICONV_VERSION} && \
    apk del .build-deps

# tomcat native

RUN apk --no-cache add -t .build-deps build-base && \
    wget http://apache.org/dist/tomcat/tomcat-connectors/native/${TOMCAT_NATIVE_VERSION}/source/tomcat-native-${TOMCAT_NATIVE_VERSION}-src.tar.gz -O- | tar -xzC /tmp && \
    cd /tmp/tomcat-native-${TOMCAT_NATIVE_VERSION}-src/native && \
    apk --no-cache add openssl-dev && ./configure --prefix=/usr/local --with-java-home=${JAVA_HOME} --with-ssl=yes && make && make install && \
    rm -r /tmp/tomcat-native-${TOMCAT_NATIVE_VERSION}-src && \
    apk del .build-deps

# start up

EXPOSE 8080
CMD ["catalina.sh", "run"]

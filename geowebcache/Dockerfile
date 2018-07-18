FROM tomcat-alpine

ENV GEOWEBCACHE_VERSION=1.12.2 \
    \
    GEOWEBCACHE_CACHE_DIR=/data/geowebcache \
    GEOWEBCACHE_OPTIONS="-Djava.awt.headless=true -server -Xms1G -Xmx2G -Xrs \
        -XX:+UseParallelGC -XX:NewRatio=2 -XX:+CMSClassUnloadingEnabled \
        -XX:PerfDataSamplingInterval=500 -XX:SoftRefLRUPolicyMSPerMB=36000"

# geowebcache

ENV JAVA_OPTS="${JAVA_OPTS} ${GEOWEBCACHE_OPTIONS}"

RUN mkdir -p ${CATALINA_HOME}/webapps/geowebcache ${GEOWEBCACHE_CACHE_DIR} /tmp/geowebcache && \
    wget http://downloads.sourceforge.net/geowebcache/geowebcache-${GEOWEBCACHE_VERSION}-war.zip -P /tmp && \
    unzip /tmp/geowebcache-${GEOWEBCACHE_VERSION}-war.zip -d /tmp/geowebcache && \
    unzip /tmp/geowebcache/geowebcache.war -d ${CATALINA_HOME}/webapps/geowebcache && \
    rm -r /tmp/geowebcache && rm /tmp/geowebcache-${GEOWEBCACHE_VERSION}-war.zip

RUN output=${GEOWEBCACHE_CACHE_DIR}/geowebcache.xml && \
    echo '<?xml version="1.0" encoding="utf-8"?>' > $output && \
    echo '<gwcConfiguration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://geowebcache.org/schema/1.12.0"' >> $output && \
    echo '     xsi:schemaLocation="http://geowebcache.org/schema/1.12.0 http://geowebcache.org/schema/1.12.0/geowebcache.xsd">' >> $output && \
    echo '  <layers />' >> $output && \
    echo '  <gridSets />' >> $output && \
    echo '  <blobStores />' >> $output && \
    echo '</gwcConfiguration>' >> $output

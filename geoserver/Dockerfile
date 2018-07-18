FROM tomcat-alpine

ENV GEOSERVER_VERSION=2.13.0 \
    JAI_VERSION=1.1.3 \
    JAI_IMAGEIO_VERSION=1.1 \
    LIBJPEG_TURBO_VERSION=1.5.3 \
    \
    GEOSERVER_DATA_DIR=/data/geoserver \
    GEOSERVER_LOG_FILE=/data/geoserver/geoserver.log \
    GEOSERVER_OPTIONS="-Djava.awt.headless=true -server -Xms2G -Xmx4G -Xrs \
        -XX:+UseParallelGC -XX:NewRatio=2 -XX:+CMSClassUnloadingEnabled \
        -XX:PerfDataSamplingInterval=500 -XX:SoftRefLRUPolicyMSPerMB=36000 \
        -Dorg.geotools.referencing.forceXY=true"

# geoserver

ENV JAVA_OPTS="${JAVA_OPTS} ${GEOSERVER_OPTIONS}"

RUN mkdir -p ${CATALINA_HOME}/webapps/geoserver ${GEOSERVER_DATA_DIR} ${GEOSERVER_DATA_DIR}/gwc /tmp/geoserver && \
    wget http://downloads.sourceforge.net/geoserver/geoserver-${GEOSERVER_VERSION}-war.zip -P /tmp && \
    unzip /tmp/geoserver-${GEOSERVER_VERSION}-war.zip -d /tmp/geoserver && \
    unzip /tmp/geoserver/geoserver.war -d ${CATALINA_HOME}/webapps/geoserver && rm -r ${CATALINA_HOME}/webapps/geoserver/data && \
    rm -r /tmp/geoserver && rm /tmp/geoserver-${GEOSERVER_VERSION}-war.zip

RUN output=${GEOSERVER_DATA_DIR}/global.xml && \
    echo '<?xml version="1.0" encoding="utf-8"?>' > $output && \
    echo '<global>' >> $output && \
    echo '  <globalServices>true</globalServices>' >> $output && \
    echo '  <settings>' >> $output && \
    echo '    <charset>UTF-8</charset>' >> $output && \
    echo '    <verbose>true</verbose>' >> $output && \
    echo '    <verboseExceptions>true</verboseExceptions>' >> $output && \
    echo '    <numDecimals>4</numDecimals>' >> $output && \
    echo '  </settings>' >> $output && \
    echo '  <jai>' >> $output && \
    echo '    <allowInterpolation>true</allowInterpolation>' >> $output && \
    echo '    <recycling>true</recycling>' >> $output && \
    echo '    <tilePriority>5</tilePriority>' >> $output && \
    echo '    <tileThreads>7</tileThreads>' >> $output && \
    echo '    <memoryCapacity>0.5</memoryCapacity>' >> $output && \
    echo '    <memoryThreshold>0.75</memoryThreshold>' >> $output && \
    echo '    <imageIOCache>true</imageIOCache>' >> $output && \
    echo '    <pngEncoderType>PNGJ</pngEncoderType>' >> $output && \
    echo '    <pngAcceleration>true</pngAcceleration>' >> $output && \
    echo '    <jpegAcceleration>true</jpegAcceleration>' >> $output && \
    echo '    <allowNativeMosaic>true</allowNativeMosaic>' >> $output && \
    echo '    <allowNativeWarp>true</allowNativeWarp>' >> $output && \
    echo '  </jai>' >> $output && \
    echo '  <coverageAccess>' >> $output && \
    echo '    <maxPoolSize>5</maxPoolSize>' >> $output && \
    echo '    <corePoolSize>5</corePoolSize>' >> $output && \
    echo '    <keepAliveTime>30000</keepAliveTime>' >> $output && \
    echo '    <queueType>UNBOUNDED</queueType>' >> $output && \
    echo '    <imageIOCacheThreshold>10240</imageIOCacheThreshold>' >> $output && \
    echo '  </coverageAccess>' >> $output && \
    echo '</global>' >> $output && \
    \
    output=${GEOSERVER_DATA_DIR}/logging.xml && \
    echo '<?xml version="1.0" encoding="utf-8"?>' > $output && \
    echo '<logging>' >> $output && \
    echo '  <level>DEFAULT_LOGGING.properties</level>' >> $output && \
    echo '  <location>'${GEOSERVER_LOG_FILE}'</location>' >> $output && \
    echo '  <stdOutLogging>false</stdOutLogging>' >> $output && \
    echo '</logging>' >> $output && \
    \
    output=${GEOSERVER_DATA_DIR}/gwc-gs.xml && \
    echo '<?xml version="1.0" encoding="utf-8"?>' > $output && \
    echo '<GeoServerGWCConfig>' >> $output && \
    echo '  <cacheLayersByDefault>false</cacheLayersByDefault>' >> $output && \
    echo '</GeoServerGWCConfig>' >> $output && \
    \
    output=${GEOSERVER_DATA_DIR}/gwc/geowebcache.xml && \
    echo '<?xml version="1.0" encoding="utf-8"?>' > $output && \
    echo '<gwcConfiguration xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://geowebcache.org/schema/1.12.0"' >> $output && \
    echo '     xsi:schemaLocation="http://geowebcache.org/schema/1.12.0 http://geowebcache.org/schema/1.12.0/geowebcache.xsd">' >> $output && \
    echo '  <layers />' >> $output && \
    echo '  <gridSets />' >> $output && \
    echo '  <blobStores />' >> $output && \
    echo '</gwcConfiguration>' >> $output

# jai

RUN wget http://download.java.net/media/jai/builds/release/${JAI_VERSION//./_}/jai-${JAI_VERSION//./_}-lib-linux-amd64.tar.gz -O- | tar -xzC /tmp && \
    wget http://download.java.net/media/jai-imageio/builds/release/${JAI_IMAGEIO_VERSION}/jai_imageio-${JAI_IMAGEIO_VERSION//./_}-lib-linux-amd64.tar.gz -O- | tar -xzC /tmp && \
    \
    mv /tmp/jai-${JAI_VERSION//./_}/lib/*.jar ${JAVA_HOME}/jre/lib/ext/ && \
    mv /tmp/jai-${JAI_VERSION//./_}/lib/*.so ${JAVA_HOME}/jre/lib/amd64/ && \
    mv /tmp/jai_imageio-${JAI_IMAGEIO_VERSION//./_}/lib/*.jar ${JAVA_HOME}/jre/lib/ext/ && \
    mv /tmp/jai_imageio-${JAI_IMAGEIO_VERSION//./_}/lib/*.so ${JAVA_HOME}/jre/lib/amd64/ && \
    \
    rm -r /tmp/jai-${JAI_VERSION//./_} && \
    rm -r /tmp/jai_imageio-${JAI_IMAGEIO_VERSION//./_} && \
    cd ${CATALINA_HOME}/webapps/geoserver/WEB-INF/lib && rm jai_core-*.jar jai_codec-*.jar jai_imageio-*.jar

# libjpeg

RUN apk --no-cache add -t .build-deps build-base nasm && \
    wget http://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-${LIBJPEG_TURBO_VERSION}.tar.gz -O- | tar -xzC /tmp && \
    cd /tmp/libjpeg-turbo-${LIBJPEG_TURBO_VERSION} && \
    ./configure --prefix=/usr/local --with-jpeg8 --with-simd && make && make install && \
    rm -r /tmp/libjpeg-turbo-${LIBJPEG_TURBO_VERSION} && \
    apk del .build-deps

RUN wget http://downloads.sourceforge.net/geoserver/GeoServer/${GEOSERVER_VERSION}/extensions/geoserver-${GEOSERVER_VERSION}-libjpeg-turbo-plugin.zip -P /tmp && \
    unzip /tmp/geoserver-${GEOSERVER_VERSION}-libjpeg-turbo-plugin.zip -d ${CATALINA_HOME}/webapps/geoserver/WEB-INF/lib && \
    rm /tmp/geoserver-${GEOSERVER_VERSION}-libjpeg-turbo-plugin.zip

# fonts

RUN apk --no-cache add fontconfig freetype font-noto unifont && \
    fc-cache -f

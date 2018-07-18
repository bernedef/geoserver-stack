FROM glibc-alpine

ENV JAVA_VERSION=8.172 \
    JAVA_VERSION_BUILD=11 \
    JAVA_HASH=a58eab1ec242421181065cdc37240b08 \
    MARLIN_VERSION=0.9.1

# java

ENV JAVA_HOME=/usr/local/java
ENV JAVA_OPTS="${JAVA_OPTS} -Dfile.encoding=UTF-8"

ENV PATH=${JAVA_HOME}/bin:${PATH}

RUN mkdir -p ${JAVA_HOME} && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION//./u}-b${JAVA_VERSION_BUILD}/${JAVA_HASH}/server-jre-${JAVA_VERSION//./u}-linux-x64.tar.gz -O- | tar -xzC ${JAVA_HOME} --strip-components=1 && \
    apk --no-cache add java-cacerts && \
    ln -sf /etc/ssl/certs/java/cacerts ${JAVA_HOME}/jre/lib/security/cacerts

# marlin

ENV JAVA_OPTS="${JAVA_OPTS} \
    -Xbootclasspath/a:${JAVA_HOME}/lib/marlin-${MARLIN_VERSION}-Unsafe.jar \
    -Dsun.java2d.renderer=org.marlin.pisces.MarlinRenderingEngine \
    -Dsun.java2d.renderer.useThreadLocal=true \
    -Dsun.java2d.renderer.pixelsize=4096"

RUN wget http://github.com/bourgesl/marlin-renderer/releases/download/v${MARLIN_VERSION//./_}/marlin-${MARLIN_VERSION}-Unsafe.jar -P ${JAVA_HOME}/lib

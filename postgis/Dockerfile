FROM postgres:10.3-alpine

ENV POSTGIS_VERSION=2.4.4 \
    GDAL_VERSION=2.2.4 \
    GEOS_VERSION=3.6.2 \
    PROJ_VERSION=5.0.1

ENV LOCALE=en_US CHARSET=UTF-8 LANG=en_US.utf8 LD_LIBRARY_PATH=/usr/local/lib

# proj

RUN apk --no-cache add -t .build-deps build-base && \
    wget http://download.osgeo.org/proj/proj-${PROJ_VERSION}.tar.gz -O- | tar -xzC /tmp && \
    cd /tmp/proj-${PROJ_VERSION} && \
    ./configure --prefix /usr/local --without-jni && make && make install && \
    rm -r /tmp/proj-${PROJ_VERSION} && \
    apk del .build-deps

# geos

RUN apk --no-cache add -t .build-deps build-base && \
    wget http://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2 -O- | tar -xjC /tmp && \
    cd /tmp/geos-${GEOS_VERSION} && \
    ./configure --prefix /usr/local --disable-glibcxx-debug && make && make install && \
    rm -r /tmp/geos-${GEOS_VERSION} && \
    apk del .build-deps

# gdal

ENV GDAL_DATA=/usr/local/share/gdal

RUN apk --no-cache add -t .build-deps build-base linux-headers && \
    wget http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz -O- | tar -xzC /tmp && \
    cd /tmp/gdal-${GDAL_VERSION} && \
    ./configure --prefix /usr/local --with-pg --with-geos && make && make install && \
    rm -r /tmp/gdal-${GDAL_VERSION} && \
    apk del .build-deps

# postgis

RUN apk --no-cache add libgcc libstdc++ zlib libxml2 json-c && \
    apk --no-cache add -t .build-deps build-base perl zlib-dev libxml2-dev json-c-dev && \
    wget http://postgis.net/stuff/postgis-${POSTGIS_VERSION}.tar.gz -O- | tar -xzC /tmp && \
    cd /tmp/postgis-${POSTGIS_VERSION} && \
    ./configure --prefix /usr/local --without-gui && make && make install && \
    ldconfig /usr/local/lib/ /usr/local/lib/postgres && \
    rm -r /tmp/postgis-${POSTGIS_VERSION} && \
    apk del .build-deps

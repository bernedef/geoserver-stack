FROM alpine:3.7

ENV GLIBC_VERSION=2.27-r0

# glibc

ENV LOCALE=en_US CHARSET=UTF-8 LANG=en_US.UTF-8 LD_LIBRARY_PATH=/usr/local/lib

RUN apk --no-cache add libgcc libstdc++ && \
    \
    for package in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION} glibc-i18n-${GLIBC_VERSION}; do \
        wget http://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/${package}.apk -P /tmp ;\
        apk --allow-untrusted add /tmp/${package}.apk ;\
        rm /tmp/${package}.apk ;\
    done ;\
    \
    /usr/glibc-compat/bin/localedef --inputfile "${LOCALE}" --charmap "${CHARSET}" "${LANG}" || true && \
    echo "export LANG=${LANG}" > /etc/profile.d/locale.sh && \
    \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' > /etc/nsswitch.conf

#!/bin/sh

until `wget --spider http://geoserver:8080/geoserver &> /dev/null`; do
  sleep 1
done

catalina.sh run

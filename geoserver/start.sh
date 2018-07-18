#!/bin/sh

until `nc -z postgis 5432 &> /dev/null`; do
  sleep 1
done

catalina.sh run

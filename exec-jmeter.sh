#!/bin/bash

COUNT=${1-1}

> console.log

#docker build -t jmeter-base jmeter-base
docker-compose stop && docker-compose rm -f

docker-compose build && docker-compose up -d && docker-compose scale master=1 slave=$COUNT

SLAVE_IP=$(docker inspect -f '{{.Name}} {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq) | grep slave | awk -F' ' '{print $2}' | tr '\n' ',' | sed 's/.$//')

echo $SLAVE_IP >> console.log

#WDIR=`docker exec -it master /bin/pwd | tr -d '\r'`
#mkdir -p results
#for filename in scripts/*.jmx; do
#    NAME=$(basename $filename)
#    NAME="${NAME%.*}"
#    eval "docker cp $filename master:/JMeterFiles/"
#    eval "docker exec -it master /bin/bash -c 'mkdir $NAME && jmeter -n -t /JMeterFiles/$filename -R $SLAVE_IP -l $NAME/$NAME.jtl'"
#    eval "docker cp master:/$NAME results/"
#done

echo "docker exec -it master /bin/bash -c 'jmeter -n -t /JMeterFiles/myvodds_testplan.jmx -R $SLAVE_IP -l JMeterFiles/myvodds_testplan.jtl'" >> console.log
echo "docker cp master:/JMeterFiles/myvodds_testplan.jtl ./results"

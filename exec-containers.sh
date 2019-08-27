#!/bin/bash

> exec-containers.log

CONTAINER_IDS=$(docker ps --format "table {{.ID}}" | tr '\n' ',')
#CONTAINER_IDS="CONTAINER ID,57806f49cd78,847f5310d1bd,5b4151138a11,9c8a9ab0a31e,0e95038207d8,c42f7f3054b4,bd28c96820a0,e8516573aaf3,add564bc0c5a,1abcf0974618docker@swarm1:~/jmeter/deploy"
echo "the value of containers is $CONTAINER_IDS" >> exec-containers.log
array=(`echo $CONTAINER_IDS | sed 's/,/\n/g'`)

for index in "${!array[@]}" 
do
	if (( $index > 1 )); 
	then
		echo "container id=${array[$index]}" >> exec-containers.log
		echo "docker exec -it ${array[$index]} /bin/bash -c 'jmeter -n -t /JMeterFiles/myvodds_testplan.jmx -l JMeterFiles/myvodds_testplan.jtl'" >> exec-containers.log
		docker exec -it ${array[$index]} /bin/bash -c 'jmeter -n -t /JMeterFiles/myvodds_testplan.jmx -l JMeterFiles/myvodds_testplan.jtl'
	fi
	
	#if [ ${array[$index]} = '73b79469fbb3' ];
	#then
		
	#fi
done

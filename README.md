------ PREPARATION ---------
CONSUL=192.168.231.188:8500

>> vi /etc/resolv.conf
search localdomain
nameserver 127.0.0.1
nameserver --the original--
>>

>>
INSTALL dnsmasq
/etc/dnsmasq.d/10-consul.conf
server=/consul/127.0.0.1#8600
<<
------ END PREPARATION ---------

------ LIVE DEMO ---------
docker stop helloworld; docker rm helloworld; docker rmi svenmalvik/helloworld
docker run -d --name consul -p 8400:8400 -p 8500:8500 -p 8600:53/udp -h node1 progrium/consul -server -bootstrap -ui-dir /ui
docker run -d -p 8080:80 --rm --name helloworld svenmalvik/helloworld
curl -X PUT -d '{ "ID": "helloworld","Name": "helloworld","Address": "127.0.0.1","Port": 8080}' http://127.0.0.1:8500/v1/agent/service/register
http :8500/v1/catalog/services
http :8500/v1/catalog/service/helloworld
dig @localhost -p 8600 helloworld.service.consul

docker run -it -P --name helloworl2 --entrypoint bash --env CONSUL=$CONSUL svenmalvik/helloworld 
/opt/envconsul -consul $CONSUL  -sanitize -upcase -prefix config/webapp /go/bin/helloworld

docker run -d --name httpd -p 80:80 httpd
docker run -it -p 81:80 --name httpdDyn --entrypoint bash --env CONSUL=$CONSUL svenmalvik/httpd
------ END OF LIVE DEMO ---------

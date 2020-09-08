This project creates a minimal Debian droplet at Digital Ocean public cloud with two very basic web applications.
First application has been written on Golang and listen tcp/8010 port.
Second application has been written on Java (particullary at Java Spring Boot), and listen tcp/8082 port.

NGINX route requests for /, /go, and /java, respectively onto localhost:80, localhost:8010, localhost:8082. 

Here is a route request topology:

                      +--- host/ --------> on localhost:80
                      |
    users --> nginx --|--- host/go --------> Golang on localhost:8010
                      |
                      +--- host/java ---------> Java Spring Boot on localhost:8082


NGINX web proxy redirect HTTP request to these two apps, using proxy_pass directive. 


You can use dev02.pub ssh key for accessing Debian droplet.

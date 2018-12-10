DevOps Coding Test
==================
# What are you going to find in this fork?

This challenge goal is to create a web service fully automated and deployed in a cloud provider.
I chose to deploy a html analog clock, which will display your machine current time in a simple, but likely way.  
The first part of it consist in choosing technologies in which this service will be implemented.

## Infrastructure as a Code tool

In order to programatically create the infrastructure needed to support this service I decided to use 
[Terraform](https://www.terraform.io/), as it was suggested in the content statement.

## Web server

The second technology to choose was related to the web server we want to use, and because of the nature of this project,
and considering the service I'm providing, I decided [NGINX](https://www.nginx.com/) was the appropriate tool.
Knowing this tool provide important capabilities like security features and load balancing, it might add value in the
afterwards, but at the moment it is only used as a simple web server

### Dockerized NGINX

The approach followed to have [NGINX](https://www.nginx.com/) available as part of the system was by pulling the latest
Docker container of it. part of the instances initialization consisted in pulling the image, and instantiate the
container adding as volume the path to the service content. An additional consideration was to map the docker port to
the html one in the instance it was running, so outside world can access it.
This docker app was implemented creating a systemd service, that starts the moment the system is up.
  
# Prerequisites

To instantiate this project you will need,
 * [Terraform](https://www.terraform.io/). Version 0.11.10
 * [aws cli] (https://aws.amazon.com/cli/)

# Initialization

The first step in order to instantiate this project will be to get credentials to [Amazon web services](https://aws.amazon.com/console/). Please
follow [this](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) instructions to create you key and secret pair if needed.
To start using AWS command line interface, you will need to proceed with the next command,
```aws configure```
After that, you can start by cloning the repository and initiate this terraform project by doing,

```
chmod +x create_env.sh
./create_env.sh
```

`create_env.sh` is a bash script that initiate the project and deploy the infrastructure.
As outcome, you will get information related to Healthcheck, the VPC id, but must importantly the URL to target in order
to access the service,     
```
Outputs:

Healthcheck = [
    {
        healthy_threshold = 3,
        interval = 10,
        matcher = 200,
        path = /v1/healthcheck,
        port = 80,
        protocol = HTTP,
        timeout = 5,
        unhealthy_threshold = 10
    }
]
Server-DNS = <HERE YOU WILL FIND THE URL TO THE SERVICE>
VPC-id = <VPC ID>
```

#Healthcheck
Even though the application server health check is taking care of te service, and we can relay on it to make it go back
to life whenever needed, we implemented an additional script that check connectivity with the server and provide status.
in order to do such thing you can run,
```
chmod +x healthcheck.sh
./healthcheck.sh -u <URL TO SERVER>
```


# To Do
* Create a role to be able to use a specific read only AWS S3 bucket to  download content and update the service
* Add a Bastion, a single point if access though ssh to te infrastructure to make it more secure.
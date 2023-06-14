# What is it?

It's an updated solution of deploying Wordpress on Minikube from [forked repo](https://github.com/aleixripoll/wordpress-minikube)


## Setup 

Use the prepared script for setup this solution on your Minikube.

In script you can define root password of MySQL or/and Kubernetes namespace.

```console

$ chmod +x exec.sh

$ ./exec.sh
```

## Usage

You can access to Wordpress through a local link

```console
$ minikube service nginx-servise --url
```

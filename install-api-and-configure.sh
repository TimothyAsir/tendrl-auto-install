#!/bin/bash

configureEtcd() {
cat > /etc/tendrl/etcd.yml <<EOF
---
:development:
  :base_key: ''
  :host: '127.0.0.1'
  :port: 2379
  :user_name: 'username'
  :password: 'password'

:test:
  :base_key: ''
  :host: '127.0.0.1'
  :port: 2379
  :user_name: 'username'
  :password: 'password'

:production:
  :base_key: ''
  :host: '${APISERVER}'
  :port: 2379
  :user_name: ''
  :password: ''
EOF
}

gethostip() {
    local _ip _myip _line _nl=$'\n'
    while IFS=$': \t' read -a _line ;do
        [ -z "${_line%inet}" ] &&
           _ip=${_line[${#_line[1]}>4?1:2]} &&
           [ "${_ip#127.0.0.1}" ] && _myip=$_ip
      done< <(LANG=C /sbin/ip addr)
    printf ${1+-v} $1 "%s${_nl:0:$[${#1}>0?0:1]}" $_myip | cut -f1  -d'/'
}


for i in "$@"
do
case $i in
    -p=*|--package=*)
    PACKAGE="${i#*=}"
    ;;
    -s=*|--configure=*)
    CONFIGURE="${i#*=}"
    ;;
    --default)
    DEFAULT=YES
    ;;
    *)
      # unknown option
    ;;
esac
done
echo PACKAGE = ${PACKAGE}

#APISERVER="hostname --ip-address" will work if the name is in DNS
APISERVER=`gethostip`

if ! rpm -qa | grep ${PACKAGE}  2>&1 > /dev/null; then
  # api not installed
  echo "Installing the package ${PACKAGE} in server ${APISERVER}..."
  yum install ${PACKAGE} -y
  if [ ! $? -eq 0 ]; then
      echo "Failed to install the package!"
      exit 0
  fi
else
  echo "Updating package ${PACKAGE} ..."
  # api installed, only update is required
  yum update ${PACKAGE} -y
  if [ ! $? -eq 0 ]; then
      echo "Failed to update the package!"
      exit 0
  fi
fi


if [[ ${PACKAGE} == *"api"* ]]; then
  echo "Configuring etcd ..."
  rm -fr /etc/tendrl/etcd.yml
  configureEtcd
  if [ ! $? -eq 0 ]; then
      echo "Etcd configuration failed!"
      exit 0
  fi
fi

echo "Selinux permissive"
res=$(/usr/sbin/getenforce) || :
if [ "$res" == "Enforcing" ]; then
  setenforce 0
fi

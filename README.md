# tendrl-auto-install
Scripts to install and configure tendrl packages

The set of ansible play book scrips can be used to configure and install
tendrl-server and tendrl-nodes remotly in a headless system.

The following are scripts can be used to initialize,
package installation, configuration and post configuration.

1) server-install.yaml
2) node-install.yaml
3) node-install-mon.yaml
4) node-install-osd.yaml
5) node-install-ceph-provisioner.yaml
6) node-install-gluster.yaml
7) install-api-and-configure.sh

Configuration file
tendrl.conf is the configuration file for providing details like
nodes, etcd-server, api-server and any other details.
Currently its sufficient to provide only the etcd server ip.

Server Installation:
server-install.yaml script can be called using ansible-playbook
to install and configure all the required packages and its dependencies
for tendrl server.

Ex.
[root@dhcp42-16 automake]# ansible-playbook server-install.yaml

This does the following tasks:

Tasks
~~~~~

1) Initialization

   checking systemd running] ***********************************

   re-checking systemd running] ********************************

   copy tendrl release repo file] ******************************

   copy tendrl dependencies repo file] *************************

   make sure firewalld installed] ******************************

   make sure firewalld disabled] *******************************

   make sure firewalld stopped] ********************************


2) Package Installation

   installing epel-release] **********************************

   installing etcd] ******************************************

   installing tendrl-api] ************************************

   Update package "api" to latest version] *******************

   Update package "commons" to latest version] ***************

   Update package "node-agent" to latest version] ************

   Update package "dashboard" to latest version] *************

   Update package "performance-monitoring" to latest version]

   Update package "alerting" to latest version] **************


3) Configuration

   configure tendrl-api] ****************************************

   configure etcd listen clients] *******************************

   configure etcd send clinets] *********************************

   configure performance-monitoring

   configuring alerting


4) Post Installation

   Restart etcd service] *************************************

   Restart httpd service] ************************************

   Restart carbon cache] *************************************

   configure etcd listen clients] ****************************

Node Installation
A tendrl node can be a mon node or osd node or gluster node or a
ceph provisioner node or it can be a node which support osd, mon,
and gluster.

The following are the yaml files can be used to install the node
based on its role.

ROLE: YAML
~~~~~~~~~~
1) ANY/Can play any role (ALL): node-install.yaml
   [root@dhcp42-16 automake]# ansible-playbook node-install.yaml

2) Ceph Mon Node: node-install-mon.yaml
   [root@dhcp42-16 automake]# ansible-playbook node-install-mon.yaml

Does the following tasks:
initialize
 checking systemd running ***********************************
 
 re-checking systemd running ********************************
 
 copy tendrl release repo file ******************************
 
 copy tendrl dependencies repo file *************************
 
 copy tendrl gdeploy repo file ******************************
 
 make sure firewalld installed ******************************
 
 make sure firewalld disabled *******************************
 
 make sure firewalld stopped ********************************


install-pkgs-node

installing epel-release *****************************

installing tendrl-node-agent ************************

installing tendrl-node-monitoring *******************


update-packages

Update package "commons" to latest version **********

Update package "node-agent" to latest version *******

Update package "node-monitoring" to latest version **


configure-node

configure node-monitoring ******************************

install ceph-mon repo *************************

Restart tendrl-node-agent ***************************

configure etcd listen clients ***********************


3) Ceph Osd Node: node-install-osd.yaml

   $ansible-playbook node-install-osd.yaml


4) Ceph Provisioner Node: node-install-ceph-provisioner.yaml

$ansible-playbook node-install-ceph-provisioner.yaml


5) Gluster Node: node-install-gluster.yaml

$ansible-playbook node-install-gluster.yaml

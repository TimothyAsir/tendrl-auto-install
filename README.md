# tendrl-auto-install
Scripts to install and configure tendrl packages

The set of ansible play book scrips can be used to install tendrl-server
and configure remotly in a headless system.

This provides and easy machanism to install and configure all the
required dependencies for tendrl server.

install-and-configure.yaml file is starting file which can be exeucted
using ansible-playbook.

It does initialization, package installation, configuration and
post configuration.

Ex.
[root@dhcp42-16 automake]# ansible-playbook install-and-configure.yaml

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


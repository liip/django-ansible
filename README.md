This project allows you to easily deploy your Django project on a Debian/Ubuntu/CentOS/RHEL Linux server.
The following services/software will be installed on the server:
* nginx
* uwsgi
* PostgreSQL
* (optional) Let's Encrypt/certbot

# Server setup
* Setup a server with Ubuntu 16.04, Debian 8 or CentOS/RHEL 7
* Create a user with passwordless sudo privileges
* Generate a passwordless ssh key with `ssh-keygen`
* Add the SSH public key to your git repository, e.g. as deploy key on GitLab/GitHub
* Check if python is installed, if not install it with `sudo apt-get install python-minimal -y`
  or `sudo yum install python`

# Project setup
* Generate Django project using the liip/django-template
* Run the install script in your project root (same directory as `manage.py`):
```
curl -sS https://raw.githubusercontent.com/liip/django-ansible/master/install.sh | /bin/bash
```
* The script added the directory `deployment/` to your project, you should add that to git
* Open the following files and update them to your requirements:
    * `deployment/hosts`: Update the host for your servers hostname/ip address and set the user
    you have created above
    * `deployment/group_vars/all`: Update all placeholder values

# Deploy
Go to the deployment directory, there are two scripts:

* ```setup.sh```: Installs all software and setups the app, you have to run this the first time and always when you
update one of the config files inside `deployment/`
* ```deploy.sh```: Updates the code only and reload the app server (uwsgi)

# License
MIT

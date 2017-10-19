This project allows you to easily deploy your Django project on a Debian/Ubuntu Linux server.
The following services/software will be installed on the server:
* nginx
* uwsgi
* PostgreSQL
* (optional) SSL with Lets Encrypt/certbot or your own certificate

# Server setup
* Setup a server with Ubuntu 16.04 or Debian 8
* Create a user with passwordless sudo privileges
* As the root user (`sudo su`), generate a passwordless ssh key with `ssh-keygen`
* Add the *root* SSH public key to your git repository, e.g. as deploy key on GitLab/GitHub
* Check if python is installed, if not install it with `sudo apt-get install python-minimal -y`
  or `sudo yum install python`

# Project setup
* Generate a Django project using https://github.com/liip-amboss/django-template
* Run the install script in your project root (same directory as `manage.py`):
```
curl -sS https://raw.githubusercontent.com/liip/django-ansible/master/install.sh | /bin/bash
```
* The script added the directory `deployment/` to your project, you should add that to git
* Open the following files and update them to your requirements:
    * `deployment/production`: Update the host for your servers hostname/ip address and set the user
    you have created above.
    * `deployment/group_vars/all`: Update all placeholder values (environment/server independent variables)
    * `deployment/group_vars/production`: Set variables for a specific environment/server

# Deploy
Go to the deployment directory, there are two scripts:

* ```setup.sh```: Installs all software and setups the app, you have to run this the first time and any time you
update one of the config files inside `deployment/`
* ```deploy.sh```: Deploys the code only and reloads the app server (uwsgi)

# Multiple environments/servers
To deploy to multiple different environments (e.g. test/staging/prod) you have to do the following:
Make a copy of the files `deployment/group_vars/production` and `deployment/production` and adjust
them for your new environment. Add the name of you new environment to the `hosts:` entry in
`deployment/site.yml`.

# Javascript single-page application frontend
You can deploy a spa with django-ansible by uncommenting the `frontend` role
in site.yml and setting some variables in `group_vars/all`.

The app has to be in a separate git repository. The repository will be checked out and
built locally, afther that the resulting files gets pushed to the server.
The project needs a package.json with a `npm run build` command
which builds the app into the `dist/` subdirectory of the project.

If the build uses a different directory than `dist/`
for the production build, set the `frontend_build_directory` variable.

To make HTML5 history mode urls work, all requests not matching a file inside
`dist/` will be rewritten by nginx to `dist/index.html`.

[vue-cli](https://github.com/vuejs/vue-cli) generates a project fulfilling these 
requirements without further modifications, except that HTML5 history mode is not
enabled by default on vue-router.

# Email
django-template uses dj-email-url to configure the email settings.

Add the configuration url to your `group_vars/<environment>` file:
```
email_url: smtp://user:password@smtp.example.com:465/?ssl=True
email_from: webmaster@example.com
```

If these variables are not set, the emails will be sent to the smtp server
running on port 25 on localhost without authentication.

# Customization
You can add additional installation steps by adding Ansible Tasks to your project.
To do this, create a directory `custom` in the `deployment` directory. This is the root directory
for your custom Ansible role, you can add tasks, handlers, templates and other Ansible artifacts here.
You also have to add your custom role to your `deployment/site.yml` under the `roles` entry.

To e.g. add a cronjob to your project, create a `tasks` directory inside `custom`, copy the file
from `examples/tasks/cronjob.yml` to `<your-project>/deployment/custom/tasks/cronjob.yml` and adjust the configuration
in this file for your needs. You also have to add a `<your-project>/deployment/custom/tasks/main.yml` file which
includes the new task file:

    - include: cronjob.yml

Example task files:

* [Cronjob](examples/tasks/cronjob.yml)
* [Additional Software](examples/tasks/additional_software.yml)
* [wkhtmltopdf](examples/tasks/wkhtmltopdf.yml)
* [Running a ./manage.py command in the background](examples/tasks/background_command.yml)

# python-rq task queue
There is an additional role "taskqueue" which setups python-rq with redis
as broker. To use it, add django-rq to your INSTALLED_APPS and define queues
with RQ_QUEUES in your Django settings file. (see example in
`tests/django_app/settings/base.py`)

Then activate the role by adding/uncommenting `- taskqueue` in your
`deployment/site.yml` file.

# License
MIT

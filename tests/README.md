# Running tests
* Setup a Ubuntu 16.04 server
* Make sure you can connect as root to the server with your ssh key
* Run the `server_setup.sh` script as root on the server
    * On DigitalOcean you can copy & paste the script into the "User Data"
      text field when you create a new Droplet
* Setup a DNS A record for your server
* Set the environment variable $SERVER to the domain of the server
* Run the `test.sh` script in this directory.
* Run `./setup.sh production` inside the `tests/django_app/deployment` directory

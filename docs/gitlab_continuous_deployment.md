# Continuous Deployment with GitLab
## Backend Setup
* Generate a ssh key with `ssh-keygen`
* Add the private key as a secret environment variable "SSH_PRIVATE_KEY" on GitLab CI
  (Settings => CI/CD => Secret Variables)
* Add the public key to the user ansible connects with (`.ssh/authorized_keys`)
* Uncomment the `deploy_staging` stage in you `.gitlab-ci.yml` and configure it:
    * Add `deploy_staging` as a stage on the top of the file
    * Set the `only` key to the branch you want the automatic deploy to execute when pushed to
    * Set the last parameter of `script: "bash scripts/deploy.sh <system>` to the name
      of your Ansible server/environment

## Frontend
If you deploy your JavaScript Single Page App frontend with django-ansible,
you can configure a trigger on its repo to run the deployment configured in the
backend repository.

**On your backend repository:**
* Add a `Pipeline trigger` under Settings => CI/CD => Pipeline triggers

**On your frontend repository:**
On GitLab, configure the Secret Variables `BACKEND_CI_TRIGGER_TOKEN`and `BACKEND_CI_TRIGGER_URL`
based on the trigger created on the backend repository.

Add the following stage to your `.gitlab-ci.yml` file and reference it on the `stages:` section:
```
deploy_staging:
  stage: deploy_staging
  tags:
   - shell
   - lxc
  script: "curl -X POST -F token=$BACKEND_CI_TRIGGER_TOKEN -F ref=develop $BACKEND_CI_TRIGGER_URL"
  only: [develop]
```

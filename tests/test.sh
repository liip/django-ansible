#!/usr/bin/env bash
set -euxo pipefail

cd django_app
`dirname $0`/../../install.sh local
git checkout -- .gitignore
cd deployment

sed -i "s/git_repo: TODO/git_repo: https:\/\/github.com\/liip\/django-ansible.git/" group_vars/all
sed -i "s/project_name: TODO/project_name: django_app/" group_vars/all

sed -i "s/project_dir: \"{{ root_dir }}\/{{ project_name }}\"/project_dir: \"{{ root_dir }}\/tests\/django_app\"/" group_vars/production
sed -i "s/domain\: TODO/domain: $SERVER/" group_vars/production

sed -i "s/<ip address\/hostname>/$SERVER/" production
sed -i "s/<user>/manager/" production

echo 'project_dir: "{{ checkout_dir }}/tests/django_app"' >> group_vars/all

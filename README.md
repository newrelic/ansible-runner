<a href="https://opensource.newrelic.com/oss-category/#community-plus"><picture><source media="(prefers-color-scheme: dark)" srcset="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/dark/Community_Plus.png"><source media="(prefers-color-scheme: light)" srcset="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/Community_Plus.png"><img alt="New Relic Open Source community plus project banner." src="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/Community_Plus.png"></picture></a>
  
# ansible-runner

This creates a docker image of Ansible. The installation steps are taken from the Ansible documentation https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html using pipx.
The container uses the latest version of python and ansible-core


## build

```bash
docker build . -t ansible
```

## run

```bash
docker run -it ansible
```

If you need to mount a virtual volume, to pass access to a file.pem for example, use a syntax like this:

```bash
docker run -it -v ~/my-local-configs/:/configs/ ansible
```


### installing newrelic with ansible-install

This uses the `newrelic_install` ansible role from this source https://github.com/newrelic/ansible-install

Import the newrelic galaxy collections
```bash
ansible-galaxy collection install ansible.windows ansible.utils
ansible-galaxy install newrelic.newrelic_install
```

Create a hosts INI file to define the various instances to install and how to connect to them, for example:
```ini
1.2.3.1 ansible_connection=ssh ansible_user=ec2-user ansible_ssh_private_key_file=/path/to/file.pem 
1.2.3.2 ansible_connection=ssh ansible_user=ec2-user ansible_ssh_private_key_file=/path/to/file.pem 
1.2.3.3 ansible_connection=ssh ansible_user=ec2-user ansible_ssh_private_key_file=/path/to/file.pem 
```

Create a playbook.yaml file such as this:
```yaml
- name: Install New Relic Infra+Logs
  hosts: all
  roles:
    - role: newrelic.newrelic_install
      vars:
        targets:
          - infrastructure
          - logs
        tags:
          foo: bar
          foo2: bar2
  environment:
    NEW_RELIC_API_KEY: <NRAK-... API key>
    NEW_RELIC_ACCOUNT_ID: <Account ID>
    NEW_RELIC_REGION: <Region US or EU>
```

Then run the following command. Note this disables the known_hosts check. You can remove the variable `ANSIBLE_HOST_KEY_CHECKING=false` if you manage the known hosts separately.
```bash
ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i hosts playbook.yaml 
```

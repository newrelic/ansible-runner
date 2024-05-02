[![Community Project header](https://github.com/newrelic/open-source-office/raw/master/examples/categories/images/Community_Project.png)](https://github.com/newrelic/open-source-office/blob/master/examples/categories/index.md#category-community-project)

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

## Support

New Relic hosts and moderates an online forum where customers can interact with
New Relic employees as well as other customers to get help and share best
practices. Like all official New Relic open source projects, there's a related
Community topic in the New Relic Explorers Hub. You can find this project's
topic/threads here:

- [New Relic Documentation](https://docs.newrelic.com): Comprehensive guidance for using our platform
- [New Relic Community](https://forum.newrelic.com): The best place to engage in troubleshooting questions
- [New Relic Developer](https://developer.newrelic.com/): Resources for building a custom observability applications
- [New Relic University](https://learn.newrelic.com/): A range of online training for New Relic users of every level
- [New Relic Technical Support](https://support.newrelic.com/) 24/7/365 ticketed support. Read more about our [Technical Support Offerings](https://docs.newrelic.com/docs/licenses/license-information/general-usage-licenses/support-plan).

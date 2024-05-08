<a href="https://opensource.newrelic.com/oss-category/#community-project"><picture><source media="(prefers-color-scheme: dark)" srcset="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/dark/Community_Project.png"><source media="(prefers-color-scheme: light)" srcset="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/Community_Project.png"><img alt="New Relic Open Source community project banner." src="https://github.com/newrelic/opensource-website/raw/main/src/images/categories/Community_Project.png"></picture></a>

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

## Contribute

We encourage your contributions to improve the `ansible-runner` repository! Keep in mind that when you submit your pull request, you'll need to sign the CLA via the click-through using CLA-Assistant. You only have to sign the CLA one time per project.

If you have any questions, or to execute our corporate CLA (which is required if your contribution is on behalf of a company), drop us an email at opensource@newrelic.com.

**A note about vulnerabilities**

As noted in our [security policy](https://github.com/newrelic/ansible-runner/security/policy), New Relic is committed to the privacy and security of our customers and their data. We believe that providing coordinated disclosure by security researchers and engaging with the security community are important means to achieve our security goals.

If you believe you have found a security vulnerability in this project or any of New Relic's products or websites, we welcome and greatly appreciate you reporting it to New Relic through [HackerOne](https://hackerone.com/newrelic).

If you would like to contribute to this project, review [these guidelines](https://github.com/newrelic/ansible-runner/blob/main/CONTRIBUTING.md).

To all contributors, we thank you! Without your contribution, this project would not be what it is today.

## License

This project is licensed under the [Apache 2.0](http://apache.org/licenses/LICENSE-2.0.txt) License.

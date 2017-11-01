# Ansible playbook AWX

![](https://i.imgur.com/4bNPi6k.png)

Basically I took a bunch of roles written by the awesome [geerlingguy](https://github.com/geerlingguy):

* geerlingguy.repo-epel
* geerlingguy.git
* geerlingguy.ansible
* geerlingguy.docker
* geerlingguy.pip
* geerlingguy.nodejs
* geerlingguy.awx

These are all specified in the `requirements.yml` file here in.

# Using Vagrant

Please consult the `servers.yml` file for the provisioning options \(`centos7`/`ubuntu-16.04`\).

1. Bring up a centos7 machine -&gt; `vagrant up awx-centos`

   provisioning should take **~20 minuets** or so - Grab yourself a cup of joe.

2. Once complete UI login via -&gt; [http://172.16.1.100](http://172.16.1.100) \(or what your custom ip may be\)  
   **username:** admin  
   **password:** password

3. CLI login -&gt; `vagrant ssh awx-centos` and then `sudo tower-cli config` This should yield:

```YAML
# User options (set with `tower-cli config`; stored in ~/.tower_cli.cfg).
host: http://localhost:80
username: admin
password: password
verify_ssl: False

# Defaults.
description_on: False
verbose: False
certificate:
format: human
color: True
use_token: False
```

Congrats, You are now ready to use both the UI and CLI of AWX !

# Using any machine ...

Use the ./playbooks/awx.yml playbook / fit it to your usecase:

```
---
- hosts: <change me>
  become: yes

  vars:
    nodejs_version: "6.x"
    pip_install_packages:
      - name: docker-py

  roles:
    - geerlingguy.repo-epel
    - geerlingguy.git
    - geerlingguy.ansible
    - geerlingguy.docker
    - geerlingguy.pip
    - geerlingguy.nodejs
    - geerlingguy.awx

  # A section i added so we can start experimenting with the cli straight away ...
  tasks:
    - pip:
        name: ansible-tower-cli
        state: latest
    - shell: tower-cli config host http://localhost:80
    - shell: tower-cli config username admin
    - shell: tower-cli config password password
    - shell: tower-cli config verify_ssl false
    - shell: tower-cli user list
```

## License

[Apache 2](https://choosealicense.com/licenses/apache-2.0/)

## Author Information

[Haggai Philip Zagury](http://www.tikalk.com/devops/haggai)


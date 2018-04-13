export KEY_PATH=~/sisense-ci.pem
ansible-playbook awx.yml -i awx.hosts --ask-pass --ask-become-pass

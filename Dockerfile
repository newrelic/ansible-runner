FROM python:latest

# Global
# ENV LANG en_US.UTF-8
# ENV LC_ALL en_US.UTF-8
RUN apt-get update -y
# Convenience for editing configs in the container
RUN apt-get install vim -y

# Install pipx
RUN python3 -m pip install pipx
RUN python3 -m pipx ensurepath

# Install ansible
RUN pipx install --include-deps ansible
RUN pipx install ansible-core

# Install other ansible dependencies
# RUN ansible-galaxy install newrelic.newrelic_install
# RUN ansible-galaxy collection install ansible.windows ansible.utils

CMD /bin/bash -c 'python3 --version; /root/.local/bin/ansible --version; /bin/bash'

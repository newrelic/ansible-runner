FROM python:latest

# Global
# ENV LANG en_US.UTF-8
# ENV LC_ALL en_US.UTF-8
RUN apt-get update -y

# Install pipx
RUN python3 -m pip install pipx
RUN python3 -m pipx ensurepath

# Install ansible
RUN pipx install --include-deps ansible
RUN pipx install ansible-core

# Install other ansible dependencies
# RUN ansible-galaxy install newrelic.newrelic_install
# RUN ansible-galaxy collection install ansible.windows ansible.utils

CMD ["bash"]

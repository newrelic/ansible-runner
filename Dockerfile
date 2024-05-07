ARG python_version=latest

# Build our actual container now.
FROM python:$python_version

# Add args to container scope.
ARG publish_target
ARG python_version
ARG package
ARG package_version
ARG maintainer=""
ARG TARGETPLATFORM=""
LABEL python=$python_version
LABEL package=$package
LABEL maintainer=$maintainer
LABEL org.opencontainers.image.description="python:$publish_target $package:$package_version $TARGETPLATFORM"

# Global
# ENV LANG en_US.UTF-8
# ENV LC_ALL en_US.UTF-8
RUN apt-get update -y
# Convenience for editing configs in the container
RUN apt-get install vim -y

# Install pipx
RUN python3 -m pip install pipx pywinrm
RUN python3 -m pipx ensurepath

# Install ansible
RUN pipx install --include-deps ansible
RUN pipx install ansible-core
# Windows WinRM dependency
RUN /root/.local/share/pipx/venvs/ansible/bin/python -m pip install pywinrm

# Install other ansible dependencies
RUN /root/.local/bin/ansible-galaxy collection install ansible.windows ansible.utils

CMD /bin/bash -c 'python3 --version; /root/.local/bin/ansible --version; /bin/bash'

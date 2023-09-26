ARG python_version=latest
ARG build_target=$python_version
ARG publish_target=$python_version

FROM python:$build_target as Builder

# Add arguments to container scope
ARG build_target
ARG package
ARG package_version

# Build our actual container now.
FROM python:$publish_target

# Add args to container scope.
ARG publish_target
ARG python_version
ARG package
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
RUN python3 -m pip install pipx
RUN python3 -m pipx ensurepath

# Install ansible
RUN pipx install --include-deps ansible
RUN pipx install ansible-core

# Install other ansible dependencies
# RUN ansible-galaxy install newrelic.newrelic_install
# RUN ansible-galaxy collection install ansible.windows ansible.utils

CMD /bin/bash -c 'python3 --version; /root/.local/bin/ansible --version; /bin/bash'

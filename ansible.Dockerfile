ARG PYTHON_IMAGE_TAG
FROM python:${PYTHON_IMAGE_TAG}

USER root

COPY ./etc/ansible /etc/ansible

RUN apt update -y \
    && apt install -y git rsync make \
    && apt autoremove -y \
    && pip install --upgrade pip

RUN useradd -m -d /home/ansible -p "" -s /bin/bash --user-group --comment "Ansible deploy user" ansible
ENV PATH=$PATH:/home/ansible/.local/bin

USER ansible

RUN pip install ansible --user
RUN git clone https://github.com/noritakaIzumi/ansible-rsync-test-repo.git /home/ansible/src

WORKDIR /home/ansible/playbook

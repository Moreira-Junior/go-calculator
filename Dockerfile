FROM ubuntu:focal
RUN mkdir -p /home/ansible
COPY main.yml /home/ansible
RUN apt-get update
RUN apt-get install -y pip
RUN pip install packaging
RUN pip install ansible
WORKDIR /home/ansible
RUN ansible-playbook main.yml
ENTRYPOINT ["tail", "-f", "/dev/null"]
# Intro
This repository contains the sonarqube-scanner-cli and ansible-lint in one container in order for my team to dynamically scan our ansible projects and write the best playbooks we can

## playbook-example.yaml
example of a yaml for me to use

## Dockerfile
Dockerfile contains sonarscannel-cli and ansible dependecies from python.
To convert it on premise we will need to also download sonarscanner and upload it to Artifactory to pull it from there in the right URL
The Dockerfile doesn't copy the playbooks, it mounts later the playbooks into the workspace directory so that the image will be strictly the scanners without any yaml files.

Walkthrough:

Build image:
```
docker build -t ansible-sonarscanner .
```
Run container:
```
docker run -it -v $(pwd)/*.yaml:/workspace ansible-sonarscanner
```
Inside Container:
```
# Lint your playbook
ansible-lint playbook.yml

# Run SonarScanner (pointing to your local SonarQube server if needed)
sonar-scanner \
  -Dsonar.projectKey=my_playbook \
  -Dsonar.sources=/workspace \
  -Dsonar.host.url=http://your-sonarqube-server:9000 \
  -Dsonar.login=<your-token>
```

the stop container when scan finnishes

# REQ!!!
* Sonarqube scanner cli to be places in Artifactory
* Base Image (OpenJDK) to compile on premise
* python dependencies

In the order Sonarqube to scan ansible, you will need 3 extentions in this repo under folder:
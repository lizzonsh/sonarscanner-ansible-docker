# Intro
This repository contains the sonarqube-scanner-cli and ansible-lint in on container in order for my team to dynamically scan our ansible projects and write the best playbooks we can

## playbook-example.yaml
example of a yaml for me to use

## Dockerfile
Dockerfile contains sonarscannel-cli and ansible dependecies from python.
To convert it on premise we will need to also download sonarscanner and upload it to (Already under reqs folder) Artifactory to pull it from there in the right URL
The Dockerfile doesn't copy the playbooks, it mounts later the playbooks into the workspace directory so that the image will be strictly the scanners without any yaml files.

Walkthrough:

Build image:
```
docker build -t ansible-sonarscanner .
```
Run container:
```
# $(pwd) current directory
docker run -it -v $(pwd):/workspace ansible-sonarscanner
```
Inside Container:
# TODO: Change to run in container, i want it to upload to sonarqube and close at the end
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

# REQ!!! - under reqs folder
* Sonarqube scanner cli to be places in Artifactory
* Base Images to compile on premise
* Plugins for Sonarqube

# On premise pipeline
* checkout (without jars)
* The dockerfile is not relevant to an ansible repo
* use oc commands to pull and deploy container to scan new code and then it drop automatically

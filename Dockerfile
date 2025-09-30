FROM openjdk:17-slim

WORKDIR /workspace

# Install Python, pip, bash, git, curl, unzip, and Ansible
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3 python3-pip bash git curl unzip ca-certificates \
    && pip3 install --no-cache-dir ansible ansible-lint

# Install SonarScanner CLI
ENV SONAR_SCANNER_VERSION=7.2.0.5079 
RUN curl -sSL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip -o sonar-scanner.zip 
RUN unzip ./sonar-scanner.zip -d /opt/ \
    && rm sonar-scanner.zip

ENV PATH="/opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin:${PATH}"

CMD ["bash"]

FROM openjdk:17-slim

WORKDIR /workspace

# Install Python, pip, bash, git, curl, unzip, and Ansible
RUN apt-get update && apt-get install -y --no-install-recommends \
      python3 python3-pip bash git curl unzip ca-certificates \
    && pip3 install --no-cache-dir ansible ansible-lint

# Install SonarScanner CLI
# TODO: Switch to Artifactory
ENV SONAR_SCANNER_VERSION=7.2.0.5079 
RUN curl -sSL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip -o sonar-scanner.zip 
RUN unzip ./sonar-scanner.zip -d /opt/ \
    && rm sonar-scanner.zip

ENV PATH="/opt/sonar-scanner-${SONAR_SCANNER_VERSION}/bin:${PATH}"

CMD bash -c "ansible-lint . && sonar-scanner \
    -Dsonar.projectKey=rotemhamalka \
    -Dsonar.sources=. \
    -Dsonar.host.url=http://172.25.96.1:9000 \
    -Dsonar.token=sqp_19b56ccdae620a099b5c4ecc484ea12799783f90"
    
    # This is for PR Decoration in AzureDevOps Sonarqube, will see error when not in PR environment
    # -Dsonar.pullrequest.key=$(System.PullRequest.PullRequestId) \ 
    # -Dsonar.pullrequest.branch=$(Build.SourceBranchName) \
    # -Dsonar.pullrequest.base=$(System.PullRequest.TargetBranch)"




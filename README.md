# Releasing an artefact

This repo provides a script that allows to tag a git repository:
- It looks if the specified build completed successfully
- Gets the commit id from the build
- Suggests you the new version
- Tags the repository

##Prepare the environment

* To enable scripts to interact with jenkins, define a 'jenkins_key' and 'jenkins_user' environment variable in your bashrc file. 
```
export jenkins_user=<username>
export jenkins_key=<api-token>
```
Replace <username> with your jenkins username (no quotes)
Replace <api-token> with the value obtained from Jenkins

* In addition to that you need some python libraries: requests, pymongo and bottle. 
```
$ curl -O http://python-distribute.org/distribute_setup.py
$ sudo python distribute_setup.py
$ sudo easy_install pip
$ sudo pip install requests
$ sudo pip install pymongo
$ sudo pip install bottle
```
* Configure github and jenkins urls in src/universal/conf/hosts.json

## Release
* Tag the artefact: ```python release.py -v jenkins_job_name build_number```
The script in src/universal/bin will look at your jenkins instance for the specified green build and tag the repository with the same name as the job.


# Dockerised HMRC-Release Container

A Docker container that provides an environment to run the release script. Use the Dockerfile to build the container image. The image will install python, pip and all dependencies required. It will also setup an ssh-config file containing a reference to your GitHub private key. This key can be passed into the container using a volume at runtime.

```
docker build -t hmrc-release .
```

### Example Usage

```
docker run -t -i -v "$GITHUB_PRIVATE_KEY_LOCATION:/root/.ssh/id_rsa_github" -e jenkins_user=$JENKINS_USER -e jenkins_key=JENKINS_KEY --entrypoint=/bin/bash --rm hmrc-release

# Setup git config for first use
git config --global user.email "$GIT_EMAIL_ADDRESS"
git config --global user.name "$GIT_USERNAME"

# Run release script
python bin/release.py business-tax-account 862
```

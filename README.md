This Puppet script starts an AWS EC2 instance, then deploys fcrepo-webapp to a stand-alone Tomcat7 application server.

Note, this script has only been tested on Ubuntu 12.10 and Mac OS X 10.6.

To run this script:

### 1. Install the following software:
* For Ubuntu:
```bash
sudo apt-get install cloud-utils puppet-common git ec2-api-tools -y
```
* For Mac OS X:
 1. We will assume you have Git already installed.
 2. First, install Puppet via [the official installers](http://docs.puppetlabs.com/guides/installation.html#mac-os-x)
 3. Retrieve the unofficial source for cloud-init/cloud-utils [here](https://github.com/lovelysystems/cloud-init)
			and install it via:
    ```python setup.py build; 
    sudo python setup.py install```
 4. Install Amazon's EC2 CLI utilities according to [these](http://www.robertsosinski.com/2008/01/26/starting-amazon-ec2-with-mac-os-x/) instructions.

### 2. Put your AWS credentials in the file: ~/.awssecret, in the form:
> export AWS_ACCESS_KEY=[your-aws-access-key]

> export AWS_SECRET_KEY=[your-aws-secret-key]

### 3. Clone this project
```bash
git clone https://github.com/futures/fcrepo-aws-puppet.git fcrepo-aws-puppet
```

### 4. Update the EC2 configuration elements found in:
> fcrepo-aws-puppet/cloud-init/create-ec2-instance.conf

### 5. Run
```bash
cd fcrepo-aws-puppet
./cloud-init/create-ec2-instance.sh
```

Note: There is a script in the root directory which can be run to try out the puppet script locally without starting an EC2 instance:
```bash
sudo ./test.sh --noop
```


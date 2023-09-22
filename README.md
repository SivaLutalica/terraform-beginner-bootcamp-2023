# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format

 **MAJOR.MINOR.PATCH**, eg. 1.12.1
 
 - **MAJOR** version when you make incompatible API changes.
 - **MINOR** version when you add funcionality in a backward compatible manner.
 - **PATCH** version when you make backward compatible bug fixes.

## Install the Terraform CLI

### #!/usr/bin/env bash for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly to distribution needs.

[How to check Linux Distribution version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)


```
$ cat /etc/os-release 

PRETTY_NAME="Ubuntu 22.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.1 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```
> Example of checking OS Version

### Considerations with the Terraform CLI changes
The Terraform CLI insallation instructions have changed due to gpg keyring changes.
So we needed to refer to the latestinsall CLI instructions via Terraform Documentation and change the scripting for install.
 
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Refactoring into Bash Scripts
While fixing the Terraform CLI gpb deprecation issues we noticed that bash scripts scteps where a considerable amount of code. So we crated a new Terraform CLI bash script decided to create a bahs script to install the Terraform CLI.

Bash script is located in [./bin/install_terraform_cli](./bin/install_terraform_cli)
- This will keep Gipod Task File ([.gitpod.yml](.gitpod.yml)) tidy
- This will allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI

#### Shebang Considerations


A Shebang (pronounced Sha-bang) tells the bash script what is the program that will interpet the script. eg. `#!/bin/bash`

ChatGPT recomended we use this format for bash `#!/usr/bin/env bash`

- for portability to different OS distributions
- will search the user`s PATH for bash executable

[en.wikipedia.org/wiki/Shebang_(Unix)](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using script in .gitpod.yml we need to point the script to a program to inetpretit.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permissions for the script file to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

We could also use 
```sh
chmod 744 ./bin/install_terraform_cli
```

[en.wikipedia.org/wiki/Chmod](https://en.wikipedia.org/wiki/Chmod)


### Github Lifecycle (Before, Init, Command)

We need to be careful when using Init because it will not rerun if we restart  an existing pod

[gitpod.io/docs/configure/workspaces/tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)

### Working with Env Vars

We can list all Environment variables using `env` command

We can filter specific env vars usign `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set variable using `export HELLO='world'

In the terminal we can unset variable using `unset HELLO`

We can set an evn var termporarily when just running a command

```sh
HELLO_WORLD='Hello World' ./bin/print_message
```

Within a ash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO_WORLD='Hello World'

echo $HELLO_WORLD
```

## Printing Vars

We can print an env var using echo eg `echo $HELLO_WORLD`


#### Scoping of Env Vars

When you open up new bash terminal in VSCode it will not be aware of env vars that you have set in another windows.

If you would want env Var to persist accros all future bash terminals that are open you need to set env vars in oyur bash profile. eg `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets storage.

```
gp env HELLO='world'
```
All future workspaces lounched will set the env vars for all bash teminals opened in thoes workspaces.

You can always set env vars in the `.gitpod.yml` but this only contain non-sensitive env vars

### AWS CLI Installation

AWS CLI is installed for this project via bash script `[./bin/install_aws_cli](./bin/install_aws_cli)`

[Install or update the latest version of the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[Environment variables to configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS Credentials is configured correctly by running following command

```sh
aws sts get-caller-identity
```

if it is succesfull you should see a json payload return that looks like this:

```json
{
    "UserId": "ADKLEIFKAHIFIOAKEGBIF",
    "Account": "654654646843",
    "Arn": "arn:aws:iam::654654646843:user/use_name"
}
```

We will need to generate AWS CLI Credentials from IAM user in order to use AWS CLI.
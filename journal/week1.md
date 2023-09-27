# Terraform Beginner Bootcamp 2023 - Week1

## Root Module Structure
Our root module structure is as follows:
```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terraform Input Variables

[developer.hashicorp.com/terraform/language/values/variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Terraform Cloud Variables

In terraform we can set 2 kind of variables:

- Environment Variables - those that you would set in your bash terminal .eg AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud credentials to be sensitive so they are not visible in the UI

### Loading Terraform Input Variables

#### var flag
We can use `-var` flag to set input variable or override a variable in the tfvars file .eg `terraform -var user_uuid = "example_id"`

#### var-file flag

The `-var-fil`e flag is used to pass Input Variable values into Terraform plan and apply commands using a file that contains the values. This allows you to save the Input Variable values in a file with a `.tfvars` extension that can be checked into source control for you variable environments you need to deploy to / manage.

#### terraform.tfvars
`.tfvars` files allow us to manage variable assignments systematically in a file with the extension `.tfvars`

#### auto.tfvars
Any variables in file ending with `*.auto.tfvars` will be loaded unlike `terraform.tfvars` where file needs to have exact name

### Order of Terraform Variables

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables
- The terraform.tfvars file, if present.
- The terraform.tfvars.json file, if present.
- Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
- Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)


# Terraform Beginner Bootcamp 2023 - Week1

# Fix git tags

Localy delete tags

```
git tag -d <tag_name>
```

Remotely delet tag

```
git push -delete origin tagname
```

Chekout commit you want to reapply tag to tag it and push the tags

```sh
git checkout <SHA>
git tag <tag_name>
git push --tags
git checkout main
```

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


## Dealing With Configuration Drift

What happens if we lose our sate file?

If you lose your state file you most likely need to tear down all your cloud infrastructure manually.

You can use terraform import but it won`t work for all cloud resources. YOu need to check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.example`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration Drift

If someon deletes or modify cloud resources manually trough ClickOps

If we run Terraform plan with attempt to put our infrastructure back to the expected state fixing Configuration Drift

### Fix using Terraform Refresh

```
terraform apply -refresh-only -auto-approve
```

## Terraform modules

### Terraform Module Structure

It is reccomended to place modules into `modules` directory when locally developing modules but you can name it whatever you want

### Passing Input Variables

We can pass input variables to module
The module has to declare the terraform variables in its own variables.tf

```tf
module "terrahouse_aws" {
	source = "./modules/terrahouse_aws"
	user_uuid = var.user_uuid
	bucket_name = var.bucket_name
} 
``` 

### Modules Sources

Using the source we can import modules from various spaces:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
	source = "./modules/terrahouse_aws"
} 
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform.

It may likely produce older examples that could be depricated. Oftern affecting providers

## Working with Files in Terraform

### Fileexists Function

This is builtin function that you can use to check for the existens of the file you want to pass to terraform

```tf
validation {
	condition = fileexists(var.error_html_filepah)
}
```

[fileexists Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5 Function 

This function computes the hash of a given string and encodes it with hexadecimal digits.

[filemd5 Function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root get the path for the root of the project

[References to Values](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```tf
resource "aws_s3_object" "error_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "error_html.html"
  source = "${path.root}/public/example.html"

  etag = filemd5("${path.root}/public/example.html")
}
```

### Terrafrom Locals
Local allows us to define local variables 
It can be verry useful when we want to transform data into another format and have referenced a variable.
locals {
	s3_origing_id = "MyS3Origin"
}

[Terrafrom Locals](https://developer.hashicorp.com/terraform/language/values/locals)

### Terrafrom Data sources

This allows us to source data from cloud resource.
This is usefull whe nwe want to reference resources without importing them.

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Jsonencode Function

jsonencode encodes a given value to a string using JSON syntax.


```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
[jsonencode Function](https://developer.hashicorp.com/terraform/language/functions/jsonencode)
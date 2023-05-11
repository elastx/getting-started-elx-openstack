# Start here

In this section, we will be generating a keypair with Terraform that will be used by the coming examples.

> WARNING: Do not have Terraform generate your keypair in production since the private key is saved in the statefiles. 

## Prerequisites

* Empty tenant/project in OpenStack
* OpenStack RC File v3 for your empty tenant/project
* Terraform
* python-openstackclient
* ssh-agent running

Since Terraform version 1.3 the backend type `swift` is [removed](https://developer.hashicorp.com/terraform/language/settings/backends/configuration#available-backends). We have updated this demo to use OpenStack Swift's S3 compatible API. This does however mean some extra prerequisites listed below.

* A created container named "terraform-state-archive" (the value of variable `bucket` in `main.tf`)
* OpenStack [EC2 Credentials](https://docs.elastx.cloud/docs/openstack-iaas/guides/ec2_credentials/)

Either append the Access and Secret keys to your OpenStack RC file or create a new file for the purpose of storing these credentials. Terraform expects them to be formatted in the following way:

```shell
export AWS_ACCESS_KEY_ID=<access key>
export AWS_SECRET_ACCESS_KEY=<secret key>
```

## Confirm authentication

Log on to the OpenStack control panel, go to the API Access section and
download an *OpenStack RC File (Identity API v3)*.

Source the downloaded file, in this example named `myproject-openrc.sh` and
downloaded while logged in as `myuser`:

```shell
$ source ~/Downloads/myproject-openrc.sh
Please enter your OpenStack Password for project myproject as user myuser:
```

```shell
$ openstack project list
+----------------------------------+-----------+
| ID                               | Name      |
+----------------------------------+-----------+
| abc51ede2adabc321e66b76ced1c2321 | myproject |
+----------------------------------+-----------+
```

## Run Terraform

```shell
$ terraform init
Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding hashicorp/null versions matching "~> 3.1"...
- Finding terraform-provider-openstack/openstack versions matching "~> 1.45"...
- Installing hashicorp/null v3.2.1...
- Installed hashicorp/null v3.2.1 (signed by HashiCorp)
- Installing terraform-provider-openstack/openstack v1.51.1...
- Installed terraform-provider-openstack/openstack v1.51.1
[...]
Terraform has been successfully initialized!
```

```shell
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # openstack_compute_keypair_v2.keypair will be created
  + resource "openstack_compute_keypair_v2" "keypair" {
      + fingerprint = (known after apply)
      + id          = (known after apply)
      + name        = "demo-gs-elastx"
      + private_key = (known after apply)
      + public_key  = (known after apply)
      + region      = (known after apply)
      + user_id     = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
[...]
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

keypair_name = demo-gs-elastx
[...]
```

## Add private key to ssh-agent

In order to continue to 01_Router_Network_Bastion you need to make sure the private part of the generated SSH key is in your ssh-agent

```shell
$ terraform output keypair_private_key | ssh-add -
Identity added: (stdin) ((stdin))
```

Run *ssh-add -l* to confirm it worked.

> WARNING: Do not have Terraform generate your keypair in production since the private key is saved in the statefiles

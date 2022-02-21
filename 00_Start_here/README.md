# Start here

In this section, we will be generating a keypair with Terraform that will be used by the coming examples.

## Prerequisities

* Empty tenant/project in OpenStack
* OpenStack RC File v3 for this empty tenant/project
* Terraform
* python-openstackclient
* ssh-agent running

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

Successfully configured the backend "swift"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "openstack" (terraform-providers/openstack) 1.28.0...

Terraform has been successfully initialized!
```

```shell
$ terraform apply
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # openstack_compute_keypair_v2.keypair will be created
  + resource "openstack_compute_keypair_v2" "keypair" {
      + fingerprint = (known after apply)
      + id          = (known after apply)
      + name        = "gs-elastx"
      + private_key = (known after apply)
      + public_key  = (known after apply)
      + region      = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
[...]
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

keypair_name = gs-elastx
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

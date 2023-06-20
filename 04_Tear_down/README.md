# Tear down

In order to tear down all created resources, you have to go back to the folders in reverse order:

```shell
$ cd 03_Web_Servers_LBaaS
$ terraform destroy
[...]
```

```shell
$ cd 02_Bastion
$ terraform destroy
[...]
```

```shell
$ cd 01_Router_Networking
$ terraform destroy
[...]
```

```shell
$ cd 00_Start_here
$ terraform destroy
[...]
```

> Don't forget to remove the private key from your ssh-agent!

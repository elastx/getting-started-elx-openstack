# Web Servers and Load Balancing

![Diagram 01](img/02.png)

## Relevant files

```less
├── example.auto.tfvars
├── main.tf
├── output.tf
└── variables.tf
```

## How to run

```shell
$ terraform init

Initializing the backend...

Initializing provider plugins...

Terraform has been successfully initialized!
[...]
```

```shell
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

[...]

Plan: 19 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

  [...]

Apply complete! Resources: 19 added, 0 changed, 0 destroyed.
Releasing state lock. This may take a few moments...

Outputs:

loadbalancer_ip = "X.X.X.X"
web_servers_ansible = <<EOT
[web_servers]
web-sto1-srv1 ansible_ssh_host=10.0.65.21
web-sto2-srv1 ansible_ssh_host=10.0.65.7
web-sto3-srv1 ansible_ssh_host=10.0.65.2
EOT
```

```shell
$ openstack loadbalancer list
+--------------------------------------+------------------------+----------------------------------+-------------+---------------------+------------------+----------+
| id                                   | name                   | project_id                       | vip_address | provisioning_status | operating_status | provider |
+--------------------------------------+------------------------+----------------------------------+-------------+---------------------+------------------+----------+
| eccd7fe2-25f7-4399-ab66-e6024807762d | default-web-se-sto-lb1 | 2b6e1867973848228ed89192c6195132 | 10.0.65.194 | ACTIVE              | ONLINE           | amphora  |
+--------------------------------------+------------------------+----------------------------------+-------------+---------------------+------------------+----------+

$ openstack server list
+--------------------------------------+-----------------------+--------+-----------------------------------------+----------------------------+--------------+
| ID                                   | Name                  | Status | Networks                                | Image                      | Flavor       |
+--------------------------------------+-----------------------+--------+-----------------------------------------+----------------------------+--------------+
| 1573c073-0ffc-44d8-a4dd-b38a1b91a21e | default-web-sto3-srv1 | ACTIVE | core_network=10.0.65.46                 | ubuntu-20.04-server-latest | v1-c1-m4-d40 |
| 2189ab40-798f-4037-bf6a-d839a98bde19 | default-web-sto1-srv1 | ACTIVE | core_network=10.0.65.183                | ubuntu-20.04-server-latest | v1-c1-m4-d40 |
| 61d5303f-8fce-44ee-97b6-95aed512bf03 | default-web-sto2-srv1 | ACTIVE | core_network=10.0.65.31                 | ubuntu-20.04-server-latest | v1-c1-m4-d40 |
| 48e7aa64-850f-456b-9b16-e173f2fd1731 | bastion-sto1-srv1     | ACTIVE | core_network=10.0.65.201, 91.197.43.245 | ubuntu-20.04-server-latest | v1-c2-m8-d80 |
+--------------------------------------+-----------------------+--------+-----------------------------------------+----------------------------+--------------+


Now you can open your favourite web browser and point it to
the loadbalancer_ip that you get in the output. If you reload
the page you will see that it will balance the load in a
round robin fashion.

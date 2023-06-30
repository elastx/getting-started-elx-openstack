variable "router_name" {
  type    = string
  default = "core_router"
}
variable "network_name" {
  type    = string
  default = "core_network"
}
variable "subnet_name" {
  type    = string
  default = "core_subnet"
}
variable "subnet_cidr" {
  type    = string
  default = "10.0.64.0/24"
}
variable "subnet_dns" {
  type    = list(any)
  default = ["8.8.8.8", "8.8.4.4"]
}
variable "external_network" { 
  default = "elx-public1" 
}
variable "external_network_id" {
  type = map(any)
  default = {
    "elx-public1" = "600b8501-78cb-4155-9c9f-23dfcba88828",
  }
}

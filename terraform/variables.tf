variable "network_id" {
  type	      = number
  default     = 1
}

variable "server_id" {
  type        = number
  default     = 1
}

variable "instance_count" {
  type        = number
  description = "Number of instances to deploy"
  default     = 1
}

variable "replicas_master" {
  type        = number
  default     = 3
  description = "Count of master replicas"
}

variable "replicas_worker" {
  type        = number
  default     = 0
  description = "Count of worker replicas"
}

variable "bootstrap" {
  type        = bool
  default     = false
  description = "Whether to deploy a bootstrap instance"
}

variable "dns_domain" {
  type        = string
  description = "Name of the Cloudflare domain"
}

variable "dns_zone_id" {
  type        = string
  description = "Zone ID of the Cloudflare domain"
}

variable "ip_loadbalancer_api" {
  description = "IP of an external loadbalancer for api (optional)"
  default     = null
}

variable "ip_loadbalancer_api_int" {
  description = "IP of an external loadbalancer for api-int (optional)"
  default     = null
}

variable "ip_loadbalancer_apps" {
  description = "IP of an external loadbalancer for apps (optional)"
  default     = null
}

variable "network_cidr" {
  type        = string
  description = "CIDR for the network"
  default     = "10.5.0.0/24"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR for the subnet"
  default     = "10.5.0.0/24"
}

variable "location" {
  type        = string
  description = "Region"
  default     = "nbg1"
}

variable "image" {
  type        = string
  description = "Image selector (either fcos or rhcos)"
  default     = "fcos"
}


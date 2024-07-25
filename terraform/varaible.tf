variable "ofl_project_name" {
  type    = string
  default = "OpsFusionLabs"
}

variable "ofl_project_creator" {
  type    = string
  default = "Terraform"
}

variable "prj_sn" {
  type = string
  default = "Ofl"
}


variable "ofl_region" {
  type    = string
  default = "ap-south-1"

}

variable "env" {
  type = string
  default = "dev"
}

# variable "ofl_dev-cidr-range" {
#   type        = string
#   default     = "10.17.0.0/24"
#   description = "CIDIR BLOCK"
# }


# variable "ofl_prod-cidr-range" {
#   type        = string
#   default     = "10.11.0.0/24"
#   description = "CIDIR BLOCK"
# }
variable "ofl_az" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

# variable "ofl_public_subnet_cidr" {
#   type    = list(string)
#   default = ["10.11.0.0/26", "10.11.0.64/26"]
# }

variable "ofl_ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-05a5bb48beb785bf1"
}

variable "inbound-port-numbers" {
  type    = list(number)
  default = [80, 443, 8080, 3389, 3306, 5432, 81]
}

variable "ofl-instance-type" {
 default = "t2.large"
}



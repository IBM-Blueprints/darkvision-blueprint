variable "name" {
  default = "darkvision"
}

variable "tier" {
  default = "dev"
}

variable "composite_name" {
  default = "${var.name}_${var.tier}"
}

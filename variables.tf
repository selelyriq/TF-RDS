variable "tags" {
  type = map(any)
}

variable "identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "username" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}

variable "final_snapshot_identifier" {
  type = string
}

variable "snapshot_identifier" {
  type = string
}

variable "multi_az" {
  type = bool
}

variable "db_subnet_group_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

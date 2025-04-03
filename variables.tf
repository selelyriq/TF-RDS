variable "tags" {
    type = map
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
# NTTDATA - DIGITAL ARCHITECTURE - ENGENIEER
# Create: Marcos Cianci - mlopesci@emeal.nttdata.com
# Date: Ter 15 Mar 2022
# Terraform Module - AWS AUTO SCALING



variable "asg_name" {    
    
    description = "Name of AutoScaling"
    type        = string
}

variable "asg_max_size" {    
    
    description = "Value maximo instance autoScaling"
    type        = number
}

variable "asg_min_size" {    
    
    description = "Value minimo instance autoscaling"
    type        = number
}

variable "health_check_grace_period" {    
    
    description = "Helath check grace period"
    type        = number
}

variable "health_check_type" {    
    
    description = "Health check type autoscaling"
    type        = string
}


variable "subnets_zones" {    
    
    description = "Network Subnets"
    type        = list(string)
}

variable "project" {    
    
    description = "Name of Project "
    type        = string
}

variable "scale_in_cooldown" {    
    
    description = "Scale in Cooldown"
    type        = string
}

variable "policy_type" {    
    
    description = "Type policy autoscaling "
    type        = string
}

variable "adjustment_type" {    
    
    description = "Set Adjustment type policy"

    type        = string
}

variable "metric_aggregation_type" {    
    
    description = "Metric Aggregation type policy"
    type        = string
}

variable "scale_out_adjustment_0" {    
    
    description = "Scale out adjustment 0"
    type        = string
}


variable "scale_out_adjustment_1" {    
    
    description = "Scale out adjustment 1"
    type        = string
}

variable "scale_out_adjustment_2" {    
    
    description = "Scale out adjustment 2"
    type        = string
}

variable "lchook_name" {    
    
    description = "Name of Lifecycle Hook"
    type        = string
}

variable "default_result" {    
    
    description = "Set Default Result"
    type        = string
}

variable "heartbeat_timeout" {    
    
    description = "Set heartbeat_timeout"
    type        = number
}

variable "lifecycle_transition" {    
    
    description = "lifecycle_transition"
    type        = string
}

variable "estimated_instance_warmup" {    
    
    description = "estimated instance warmup"
    type        = number
}

variable "ami" {    
    
    description = "AMI instance"
    type        = string

}

variable "instance_type" {    
    
    description = "Type instnance"
    type        = string

}
variable "iam_instance_profile" {    
    
    description = "iam instance profile"
    type        = string
}

variable "disk_size" {    
    
    description = "Size Disk Instance"
    type        = string
}

variable "alias" {    
    
    description = "alias"
    type        = string
}

variable "stack" {    
    
    description = "stack project"
    type        = string
}

variable "deploy_bucket" {    
    
    description = "Deploy bucket"
    type        = string
}

variable "environments" {    
    
    description = "Environments Developer/Production"
    type        = string
}

variable "security_groups" {    
    
    description = "Security Groups"
    type        = list(string)
}

variable "template" {    
    
    description = "Template file user data"
    type        = string
}

variable "key_name" {    
    
    description = "Name Key Ec2"
    type        = string
}

variable "load_balancers" {

    description = "Load Balancers"
    type        = string
}
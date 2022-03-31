# NTTDATA - DIGITAL ARCHITECTURE - ENGENIEER
# Create: Marcos Cianci - mlopesci@emeal.nttdata.com
# Date: Ter 15 Mar 2022
# Terraform Module - AWS AUTO SCALING


### AWS ASG - Auto Scaling ####  
resource "aws_autoscaling_group" "autoscaling" {    
    
    
    name                        = var.asg_name
    max_size                    = var.asg_max_size
    min_size                    = var.asg_min_size
    health_check_grace_period   = var.health_check_grace_period
    health_check_type           = var.health_check_type
    

    default_cooldown            = "300"

    launch_configuration        = aws_launch_configuration.LaunchConfiguration.name
    load_balancers              = [ var.load_balancers ] 
    vpc_zone_identifier         = var.subnets_zones    
    
    termination_policies        = [        
        
        "OldestLaunchConfiguration",
        "OldestInstance"
    ]

    enabled_metrics = [

        "GroupMinSize",
        "GroupMaxSize",
        "GroupDesiredCapacity",
        "GroupInServiceInstances",
        "GroupPendingInstances",
        "GroupStandbyInstances",
        "GroupTerminatingInstances",
        "GroupTotalInstances"

    ]    

    tag {         
        key                 = "Name"
        value               = "${var.project}-${var.stack}-autoscaled"
        propagate_at_launch = true
    }
}

#AutoScaling Policy
resource "aws_autoscaling_policy" "asg_scale_in" {        
    
        name                    = "scale-in-${var.project}-${var.stack}"
        policy_type             = "SimpleScaling"
        scaling_adjustment      = -2
        adjustment_type         = "ChangeInCapacity"
        cooldown                = var.scale_in_cooldown
        autoscaling_group_name  = aws_autoscaling_group.autoscaling.name
}

resource "aws_autoscaling_policy" "asg_scale_out" {       
    
        name                         = "scale-out-${var.project}-${var.stack}"
        policy_type                  = var.policy_type
        adjustment_type              = var.adjustment_type
        autoscaling_group_name       = aws_autoscaling_group.autoscaling.name
        metric_aggregation_type      = var.metric_aggregation_type
        estimated_instance_warmup    = var.estimated_instance_warmup       
       
        step_adjustment {

            scaling_adjustment          = var.scale_out_adjustment_0
            metric_interval_lower_bound = 0.0
            metric_interval_upper_bound = 10.0
        }

        step_adjustment {

            scaling_adjustment          = var.scale_out_adjustment_1
            metric_interval_lower_bound = 10.0
            metric_interval_upper_bound = 20.0
       
       }
       step_adjustment {
            scaling_adjustment          = var.scale_out_adjustment_2
            metric_interval_lower_bound = 20.0
       }
}

#Lifecycle Hook
resource "aws_autoscaling_lifecycle_hook" "asg_lifecycle" {    
    
    name                    = var.lchook_name
    autoscaling_group_name  = aws_autoscaling_group.autoscaling.name
    default_result          = var.default_result
    heartbeat_timeout       = var.heartbeat_timeout
    lifecycle_transition    = var.lifecycle_transition
}



resource "aws_autoscaling_attachment" "ags_attachment" {

    autoscaling_group_name  = aws_autoscaling_group.autoscaling.id
    elb                     = var.load_balancers
}


# LaunchConfiguration
resource "aws_launch_configuration" "LaunchConfiguration" {    
    
    lifecycle {
        create_before_destroy = true
    }    
    
    name_prefix                     = "lc-${var.project}-${var.stack}"
    image_id                        = var.ami
    iam_instance_profile            = var.iam_instance_profile
    instance_type                   = var.instance_type
    key_name                        = var.key_name    
    
    root_block_device {        
        
        volume_type     = "gp2"
        volume_size     = var.disk_size
    }    
    
    associate_public_ip_address     = false
    ebs_optimized                   = false
    enable_monitoring               = false
    security_groups                 = var.security_groups
    user_data                       = data.template_file.user_data.rendered
}

data "template_file" "user_data" {    
    
    template                        = var.template
    
    vars = {
        application                 = var.stack
        alias                       = var.alias
        bucket                      = var.deploy_bucket
        environment                 = var.environments
    }
}




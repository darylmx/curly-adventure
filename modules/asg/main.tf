resource "aws_launch_configuration" "launchconfig" {

  name_prefix = "${var.name}-launchconfig"

  image_id        = var.image_id
  instance_type   = var.instance_type
  security_groups = ["${var.security_group_id}"]

  user_data = templatefile("${var.template_file_path}", "${var.template_file_data}")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling" {
  name = "${var.name}-autoscalinggroup"

  vpc_zone_identifier  = var.vpc_zone_identifier[0]
  launch_configuration = aws_launch_configuration.launchconfig.name

  min_size = var.min_size
  max_size = var.max_size

  min_elb_capacity          = var.min_elb_capacity
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = ["${var.load_balancer_name}"]
  force_delete              = false #prevents resources from dangling

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${aws_launch_configuration.launchconfig.name}-asg"
    propagate_at_launch = true #propagate tag to compute instances
  }
}

resource "aws_autoscaling_policy" "target-tracking-policy" {
  name = "${var.name}-target_tracking_policy"

  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.autoscaling.name
  estimated_instance_warmup = 200

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = "40"
  }
}

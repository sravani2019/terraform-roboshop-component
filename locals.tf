locals {
    sg_id = data.aws_ssm_parameter.sg_id.value
    private_subnet_id= split(",", data.aws_ssm_parameter.private_subnet_id.value)[0]
    ami_id = data.aws_ami.joindevops.id
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    backend_lb_listener_arn = data.aws_ssm_parameter.backend_lb_listener_arn.value
    frontend_alb_listener_arn = data.aws_ssm_parameter.frontend_alb_listener_arn.value
    alb_listener_arn = var.component == "frontend" ? local.frontend_alb_listener_arn : local.backend_lb_listener_arn
    host_header = var.component == "frontend" ? "${var.project}-${var.environment}.${var.domain-name}" : "${var.component}.backend-lb-${var.environment}.${var.domain-name}"
    common_tags = {
        project = var.project
        environment = var.environment
        terraform = true
    }
    common_name = "${var.project}-${var.environment}-${var.component}"
}

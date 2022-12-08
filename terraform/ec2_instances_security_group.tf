
resource "aws_security_group" "security_group_main_app_instances" {
  name = "${var.service_name}__${var.environment}__Security_Group__EC2_Instances"
  description = "Main App EC2 Instances security group (${var.service_name}/${var.environment})"
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "${var.service_name}__${var.environment}__Security_Group__EC2_Instances"
  }
}

resource "aws_security_group_rule" "security_group_main_app_load_balancer__ingress_port8000_load_balancer" {
  security_group_id = aws_security_group.security_group_main_app_instances.id
  type              = "ingress"
  description       = "Allow ingress: Port 8000 from Load Balancer"
  protocol          = "tcp"
  from_port         = 8000
  to_port           = 8000
  source_security_group_id = aws_security_group.security_group_main_app_load_balancer.id
}

resource "aws_security_group_rule" "security_group_main_app_load_balancer__egress_port8000_load_balancer" {
  security_group_id = aws_security_group.security_group_main_app_instances.id
  type              = "egress"
  description       = "Allow egress: Port 8000 to Load Balancer"
  protocol          = "tcp"
  from_port         = 8000
  to_port           = 8000
  source_security_group_id = aws_security_group.security_group_main_app_load_balancer.id
}

resource "aws_security_group_rule" "security_group_main_app_load_balancer__ingress_port8000_all" {
  security_group_id = aws_security_group.security_group_main_app_instances.id
  type              = "ingress"
  description       = "Allow ingress: All"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "security_group_main_app_load_balancer__egress_port8000_all" {
  security_group_id = aws_security_group.security_group_main_app_instances.id
  type              = "egress"
  description       = "Allow egress: all"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
}

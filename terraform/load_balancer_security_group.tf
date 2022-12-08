
resource "aws_security_group" "security_group_main_app_load_balancer" {
  name = "${var.service_name}__${var.environment}__Security_Group__Application_Load_Balancer"
  description = "Load Balancer security group (${var.service_name}/${var.environment})"
  vpc_id = aws_vpc.vpc_main.id

  tags = {
    Name = "${var.service_name}__${var.environment}__Security_Group__Application_Load_Balancer"
  }
}

resource "aws_security_group_rule" "security_group_main_app_load_balancer__ingress_port80_everywhere" {
  security_group_id = aws_security_group.security_group_main_app_load_balancer.id
  type              = "ingress"
  description       = "Allow ingress: Port 80 from everywhere"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "security_group_main_app_load_balancer__ingress_port8000_instances" {
  security_group_id = aws_security_group.security_group_main_app_load_balancer.id
  type              = "ingress"
  description       = "Allow ingress: Port 8000 from EC2 Instances"
  protocol          = "tcp"
  from_port         = 8000
  to_port           = 8000
  source_security_group_id = aws_security_group.security_group_main_app_instances.id
}

resource "aws_security_group_rule" "security_group_main_app_load_balancer__egress_port80_everywhere" {
  security_group_id = aws_security_group.security_group_main_app_load_balancer.id
  type              = "egress"
  description       = "Allow egress: Port 80 to everywhere"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "security_group_main_app_load_balancer__egress_port8000_instances" {
  security_group_id = aws_security_group.security_group_main_app_load_balancer.id
  type              = "egress"
  description       = "Allow egress: Port 8000 to EC2 Instances"
  protocol          = "tcp"
  from_port         = 8000
  to_port           = 8000
  source_security_group_id = aws_security_group.security_group_main_app_instances.id
}

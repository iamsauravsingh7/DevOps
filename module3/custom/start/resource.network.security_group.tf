module "server-sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.17.1"

  name        = "${var.prefix}-server"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  # ammend ingress rules to allow ssh too
  ingress_rules = ["ssh-tcp"]
}

module "alb-sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.17.1"

  name        = "${var.prefix}-alb"
  description = "Allow inbound http traffic"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

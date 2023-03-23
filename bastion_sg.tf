resource "aws_security_group" "bastion_sg" {
    name = "bastion_sg"
    description = "allow all"
    vpc_id = module.vpc.vpc_id

    ingress {
        description = "allow all for eks"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    egress = [

        {
            description = "allow all"
            from_port = 0
            to_port = 0
            protocol = "-1"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            aws_security_groups = []
            prefix_list_ids = []
            self = false
            security_groups = []
        }
    ]
    tags = {
        Name = "allow all"
    }
}



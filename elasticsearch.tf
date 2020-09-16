
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "es" {
  domain_name = var.es_domain
  elasticsearch_version = "7.7"

  cluster_config {
      instance_type = "t2.small.elasticsearch"
  }

  ebs_options {
      ebs_enabled = true
      volume_size = 10
  }
/*
  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Action": "es:*",
          "Principal": "*",
          "Effect": "Allow",
          "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.es_domain}/*"
      }
  ]
}
CONFIG
*/
  snapshot_options {
      automated_snapshot_start_hour = 23
  }

  tags = {
      Domain = var.es_domain
  }
}

output "ElasticSearch_Endpoint" {
  value = aws_elasticsearch_domain.es.endpoint
}

output "ElasticSearch_Kibana_Endpoint" {
  value = aws_elasticsearch_domain.es.kibana_endpoint
}
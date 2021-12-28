# Example Private API Gateway with Terraform Compliance Lambda


* Update backend.tf terraform bucket name

```bash
terraform init
terraform apply

output:
apigw_url = "https://k0obsrp6xj.execute-api.us-east-1.amazonaws.com/dev"
```
* Create a temporary directory and main.tf file

```bash
mkdir /tmp/terraform_test
cd /tmp/terraform_test
```

main.tf
--------
```bash
provider "aws" {
    region = "us-east-1"
}

resource "aws_s3_bucket" "b" {
  bucket = "test"
  tags = {
    Name = "test"
  }
}
```
* Get the tfplan for the terrform

```bash
terraform init
terraform plan -out=terraform.tfplan
terraform show -json terraform.tfplan > output.json^
```

* Call the API endpoint from within the VPC

```bash
value=$(<output.json) && curl -H "Content-Type:application/json" -d "$value" https://k0obsrp6xj.execute-api.us-east-1.amazonaws.com/dev/summary | jq
```


```json
{
  "results": [
    {
      "description": "ALB protocol must be HTTPS\nrelated resources: aws_alb_listener, aws_lb_listener",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 7,
          "name": "ALB protocol must be HTTPS",
          "steps": [
            {
              "keyword": "Given",
              "line": 8,
              "name": "Given I have aws_lb_listener defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 9,
              "name": "Then its protocol must be HTTPS",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "1",
      "keyword": "Feature",
      "line": 1,
      "name": "ALB related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/ALB.feature"
    },
    {
      "description": "Cloudfront distribution default ViewerProtocolPolicy must set to HTTPS # unsure if this scenario is correct\nrelated resources: aws_cloudfront_distribution",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 6,
          "name": "Cloudfront distribution default ViewerProtocolPolicy must set to HTTPS",
          "steps": [
            {
              "keyword": "Given",
              "line": 7,
              "name": "Given I have aws_cloudfront_distribution defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 8,
              "name": "Then it must have default_cache_behavior",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 9,
              "name": "And it must have viewer_protocol_policy",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 10,
              "name": "And its value must not be allow-all",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "2",
      "keyword": "Feature",
      "line": 1,
      "name": "Cloudfront related general features.",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/Cloudfront.feature"
    },
    {
      "description": "related resources: aws_cloudtrail",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 5,
          "name": "Ensure CloudTrail logs are encrypted at rest using KMS CMKs",
          "steps": [
            {
              "keyword": "Given",
              "line": 6,
              "name": "Given I have aws_cloudtrail defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 7,
              "name": "Then it must have kms_key_id",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 8,
              "name": "And its value must not be null",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 11,
          "name": "Ensure CloudTrail log file validation is enabled",
          "steps": [
            {
              "keyword": "Given",
              "line": 12,
              "name": "Given I have aws_cloudtrail defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 13,
              "name": "Then it must have enable_log_file_validation",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 14,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "3",
      "keyword": "Feature",
      "line": 1,
      "name": "Cloudtrail related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/Cloudtrail.feature"
    },
    {
      "description": "DynamoDB point in time recovery (backup) must be enabled\nrelated resources: aws_dynamodb_table",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 6,
          "name": "DynamoDB point in time recovery (backup) must be enabled",
          "steps": [
            {
              "keyword": "Given",
              "line": 7,
              "name": "Given I have aws_dynamodb_table defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 8,
              "name": "Then it must contain point_in_time_recovery",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 9,
              "name": "Then it must contain enabled",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 10,
              "name": "Then its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 12,
          "name": "data must be encrypted",
          "steps": [
            {
              "keyword": "Given",
              "line": 13,
              "name": "Given I have aws_dynamodb_table defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 14,
              "name": "Then it must contain server_side_encryption",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 15,
              "name": "And it must contain enabled",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 16,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "4",
      "keyword": "Feature",
      "line": 1,
      "name": "DynamoDB related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/DynamoDB.feature"
    },
    {
      "description": "Data must be encrypted at rest\nrelated resources: aws_ebs_volume",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 6,
          "name": "Data must be encrypted at rest",
          "steps": [
            {
              "keyword": "Given",
              "line": 7,
              "name": "Given I have aws_ebs_volume defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 8,
              "name": "Then its encrypted must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "5",
      "keyword": "Feature",
      "line": 1,
      "name": "EBS related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/EBS.feature"
    },
    {
      "description": "",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 4,
          "name": "Ensure encryption on EC2 instance volumes",
          "steps": [
            {
              "keyword": "Given",
              "line": 5,
              "name": "Given I have aws_instance defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 6,
              "name": "When it has root_block_device",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 7,
              "name": "Then it must have root_block_device",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 8,
              "name": "Then it must have encrypted",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 9,
              "name": "And its value must be True",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 11,
          "name": "Ensure all data stored in the Launch configuration EBS is securely encrypted",
          "steps": [
            {
              "keyword": "Given",
              "line": 12,
              "name": "Given I have aws_instance defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 13,
              "name": "When it has ebs_block_device",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 14,
              "name": "Then it must have ebs_block_device",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 15,
              "name": "When it has snapshot_id",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 16,
              "name": "When its snapshot_id is false",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 17,
              "name": "Then it must have encrypted",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 18,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "3",
          "keyword": "Scenario",
          "line": 21,
          "name": "Ensure all data stored in the Launch configuration EBS is securely encrypted (launch_configuration)",
          "steps": [
            {
              "keyword": "Given",
              "line": 22,
              "name": "Given I have aws_launch_configuration defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 23,
              "name": "When it has ebs_block_device",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 24,
              "name": "Then it must have ebs_block_device",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 25,
              "name": "When it has snapshot_id",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 26,
              "name": "When its snapshot_id is false",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 27,
              "name": "Then it must have encrypted",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 28,
              "name": "And its value must be True",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "6",
      "keyword": "Feature",
      "line": 1,
      "name": "EC2 related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/EC2.feature"
    },
    {
      "description": "ECR policy must not be public\nECR image scanning on push must be enabled\nrelated resources: aws_ecr_repository_policy, aws_ecr_repository",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 8,
          "name": "ECR policy must not be public",
          "steps": [
            {
              "keyword": "Given",
              "line": 9,
              "name": "Given I have aws_ecr_repository_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 10,
              "name": "Then it must have policy",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 11,
              "name": "When it has statement",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 12,
              "name": "Then it must have statement",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 13,
              "name": "And it must have Principal",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 14,
              "name": "And its value must not be *",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 17,
          "name": "ECR image scanning on push must be enabled",
          "steps": [
            {
              "keyword": "Given",
              "line": 18,
              "name": "Given I have aws_ecr_repository defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 19,
              "name": "Then it must have image_scanning_configuration",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 20,
              "name": "And its scan_on_push must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "7",
      "keyword": "Feature",
      "line": 1,
      "name": "ECR related general feature.",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/ECR.feature"
    },
    {
      "description": "",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 3,
          "name": "Ensure EFS is encrypted",
          "steps": [
            {
              "keyword": "Given",
              "line": 4,
              "name": "Given I have aws_efs_file_system defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 5,
              "name": "Then it must have encrypted",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 6,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "8",
      "keyword": "Feature",
      "line": 1,
      "name": "EFS related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/EFS.feature"
    },
    {
      "description": "",
      "elements": [
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario Outline",
          "line": 3,
          "name": "Ensure Amazon EKS control plane logging enabled for all log types - row 0",
          "steps": [
            {
              "keyword": "Given",
              "line": 10,
              "name": "Given I have aws_eks_cluster defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 10,
              "name": "Then it must have enabled_cluster_log_types",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 10,
              "name": "Then it must contain api",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "3",
          "keyword": "Scenario Outline",
          "line": 3,
          "name": "Ensure Amazon EKS control plane logging enabled for all log types - row 1",
          "steps": [
            {
              "keyword": "Given",
              "line": 11,
              "name": "Given I have aws_eks_cluster defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 11,
              "name": "Then it must have enabled_cluster_log_types",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 11,
              "name": "Then it must contain audit",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "4",
          "keyword": "Scenario Outline",
          "line": 3,
          "name": "Ensure Amazon EKS control plane logging enabled for all log types - row 2",
          "steps": [
            {
              "keyword": "Given",
              "line": 12,
              "name": "Given I have aws_eks_cluster defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 12,
              "name": "Then it must have enabled_cluster_log_types",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 12,
              "name": "Then it must contain authenticator",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "5",
          "keyword": "Scenario Outline",
          "line": 3,
          "name": "Ensure Amazon EKS control plane logging enabled for all log types - row 3",
          "steps": [
            {
              "keyword": "Given",
              "line": 13,
              "name": "Given I have aws_eks_cluster defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 13,
              "name": "Then it must have enabled_cluster_log_types",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 13,
              "name": "Then it must contain controllerManager",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "6",
          "keyword": "Scenario Outline",
          "line": 3,
          "name": "Ensure Amazon EKS control plane logging enabled for all log types - row 4",
          "steps": [
            {
              "keyword": "Given",
              "line": 14,
              "name": "Given I have aws_eks_cluster defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 14,
              "name": "Then it must have enabled_cluster_log_types",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 14,
              "name": "Then it must contain scheduler",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "7",
          "keyword": "Scenario",
          "line": 17,
          "name": "Ensure Amazon EKS public endpoint not accessible to 0.0.0.0/0",
          "steps": [
            {
              "keyword": "Given",
              "line": 18,
              "name": "Given I have aws_eks_cluster defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 19,
              "name": "Then it must have vpc_config",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 20,
              "name": "When its endpoint_public_access is true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 21,
              "name": "Then it must have public_access_cidrs",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 22,
              "name": "And it must not contain 0.0.0.0/0",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "9",
      "keyword": "Feature",
      "line": 1,
      "name": "EKS related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/EKS.feature"
    },
    {
      "description": "Data must be encrypted at rest\nData in elasticache replication group must be encrypted at transit\nrelated resources: aws_elasticache_replication_group",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 7,
          "name": "Data must be encrypted at rest",
          "steps": [
            {
              "keyword": "Given",
              "line": 8,
              "name": "Given I have aws_elasticache_replication_group defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 9,
              "name": "Then its at_rest_encryption_enabled must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 12,
          "name": "Data in elasticache replication group must be encrypted at transit",
          "steps": [
            {
              "keyword": "Given",
              "line": 13,
              "name": "Given I have aws_elasticache_replication_group defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 14,
              "name": "Then its transit_encryption_enabled must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "3",
          "keyword": "Scenario",
          "line": 17,
          "name": "Data in elasticache replication must be protected by an auth token",
          "steps": [
            {
              "keyword": "Given",
              "line": 18,
              "name": "Given I have aws_elasticache_replication_group defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 19,
              "name": "When its transit_encryption_enabled is true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 20,
              "name": "Then it must have auth_token",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 21,
              "name": "And its value must not be null",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "10",
      "keyword": "Feature",
      "line": 1,
      "name": "Elasticache related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/Elasticache.feature"
    },
    {
      "description": "",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 5,
          "name": "Ensure all data stored in the Elasticsearch is securely encrypted at rest",
          "steps": [
            {
              "keyword": "Given",
              "line": 6,
              "name": "Given I have aws_elasticsearch_domain defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 7,
              "name": "Then it must have encrypt_at_rest",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 8,
              "name": "And its value must be True",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 11,
          "name": "Ensure all Elasticsearch has node-to-node encryption enabled",
          "steps": [
            {
              "keyword": "Given",
              "line": 12,
              "name": "Given I have aws_elasticsearch_domain defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 13,
              "name": "Then it must have node_to_node_encryption",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 14,
              "name": "And it must have enabled",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 15,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "11",
      "keyword": "Feature",
      "line": 1,
      "name": "Elasticsearch related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/Elasticsearch.feature"
    },
    {
      "description": "IAM policies that allows full priviliges must not be created\nIAM password should:\n- be longer than 13 characters (min 14)\n- have at least one uppercase/lowercase letter\n- have at least one number\n- not be reused??\n- have at least one symbol\nrelated resources: aws_iam_policy_document, aws_iam_account_password_policy, aws_iam_policy",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 13,
          "name": "IAM password should be loneger than 13 characters",
          "steps": [
            {
              "keyword": "Given",
              "line": 14,
              "name": "Given I have aws_iam_account_password_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 15,
              "name": "Then it must have minimum_password_length",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 16,
              "name": "And its value must be greater than 13",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 19,
          "name": "IAM password should require uppercase characters",
          "steps": [
            {
              "keyword": "Given",
              "line": 20,
              "name": "Given I have aws_iam_account_password_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 21,
              "name": "Then it must have require_uppercase_characters",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 22,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "3",
          "keyword": "Scenario",
          "line": 25,
          "name": "IAM password should require lowercase characters",
          "steps": [
            {
              "keyword": "Given",
              "line": 26,
              "name": "Given I have aws_iam_account_password_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 27,
              "name": "Then it must have require_lowercase_characters",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 28,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "4",
          "keyword": "Scenario",
          "line": 31,
          "name": "IAM password should require numbers",
          "steps": [
            {
              "keyword": "Given",
              "line": 32,
              "name": "Given I have aws_iam_account_password_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 33,
              "name": "Then it must have require_numbers",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 34,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "5",
          "keyword": "Scenario",
          "line": 37,
          "name": "Ensure IAM password policy requires at least one symbol",
          "steps": [
            {
              "keyword": "Given",
              "line": 38,
              "name": "Given I have aws_iam_account_password_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 39,
              "name": "Then it must have require_symbols",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 40,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "6",
          "keyword": "Scenario",
          "line": 43,
          "name": "Ensure IAM password policy prevents password reuse",
          "steps": [
            {
              "keyword": "Given",
              "line": 44,
              "name": "Given I have aws_iam_account_password_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 45,
              "name": "Then it must have password_reuse_prevention",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 46,
              "name": "And its value must be greater than 0",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "7",
          "keyword": "Scenario",
          "line": 49,
          "name": "IAM policies that allows full priviliges must not be created",
          "steps": [
            {
              "keyword": "Given",
              "line": 50,
              "name": "Given I have aws_iam_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 51,
              "name": "When it has policy",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 52,
              "name": "Then it must have policy",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 53,
              "name": "When it has Statement",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 54,
              "name": "Then it must have Statement",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 55,
              "name": "When its Effect is Allow",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 56,
              "name": "And its Action is sts:AssumeRole",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 57,
              "name": "Then it must contain resource",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 58,
              "name": "And its value must not be *",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "8",
          "keyword": "Scenario",
          "line": 62,
          "name": "Ensure IAM password policy expires passwords within 90 days or less",
          "steps": [
            {
              "keyword": "Given",
              "line": 63,
              "name": "Given I have aws_iam_account_password_policy defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 64,
              "name": "Then it must have max_password_age",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 65,
              "name": "And its value must be less than 91",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "9",
          "keyword": "Scenario",
          "line": 68,
          "name": "Ensure there are no iam user policy attachments",
          "steps": [
            {
              "keyword": "Given",
              "line": 69,
              "name": "Given I have aws_iam_user_policy_attachment defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 70,
              "name": "Then it must fail",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "12",
      "keyword": "Feature",
      "line": 1,
      "name": "IAM related general features",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/IAM.feature"
    },
    {
      "description": "",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 3,
          "name": "Ensure rotation for customer created CMKs is enabled",
          "steps": [
            {
              "keyword": "Given",
              "line": 4,
              "name": "Given I have aws_kms_key defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 5,
              "name": "Then it must have enable_key_rotation",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 6,
              "name": "And its value must be True",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "13",
      "keyword": "Feature",
      "line": 1,
      "name": "KMS related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/KMS.feature"
    },
    {
      "description": "",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 3,
          "name": "Ensure Kinesis Stream is encrypted",
          "steps": [
            {
              "keyword": "Given",
              "line": 4,
              "name": "Given I have aws_kinesis_stream defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 5,
              "name": "Then it must have encryption_type",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 6,
              "name": "And its value must not be NONE",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "14",
      "keyword": "Feature",
      "line": 1,
      "name": "Kinesis related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/Kinesis.feature"
    },
    {
      "description": "data should be encrypted at rest\ndata should not be public\nrelated resources: aws_db_instance, aws_rds_cluster_instance",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 9,
          "name": "data should not be public",
          "steps": [
            {
              "keyword": "Given",
              "line": 10,
              "name": "Given I have aws_db_instance defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 11,
              "name": "Then its publicly_accessible must be false",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 14,
          "name": "Ensure all data stored in the RDS is securely encrypted at rest",
          "steps": [
            {
              "keyword": "Given",
              "line": 15,
              "name": "Given I have aws_db_instance defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 16,
              "name": "When its replicate_source_db is None",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 17,
              "name": "Then it must have storage_encrypted",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 18,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "3",
          "keyword": "Scenario",
          "line": 21,
          "name": "RDS Cluster data should not be publicly accessible",
          "steps": [
            {
              "keyword": "Given",
              "line": 22,
              "name": "Given I have aws_rds_cluster_instance defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 23,
              "name": "Then its publicly_accessible must be false",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "15",
      "keyword": "Feature",
      "line": 2,
      "name": "RDS related general feature",
      "tags": [
        {
          "line": 1,
          "name": "@rds"
        }
      ],
      "type": "feature",
      "uri": "/var/task/features/RDS.feature"
    },
    {
      "description": "Implemented\n- Data must be encrypted at rest (what if it's suppose to be public?, maybe check if it's suppose to be public before? What if it's mistakenly set as public?)\n- Data stored in S3 has versioning enabled\nQuestionable checks (only checks if one pass)\n- S3 must have access logging enabled",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 12,
          "name": "Data must be encrypted at rest",
          "steps": [
            {
              "keyword": "Given",
              "line": 13,
              "name": "Given I have aws_s3_bucket defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 14,
              "name": "Then it must have server_side_encryption_configuration",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 19,
          "name": "S3 must have access logging enabled",
          "steps": [
            {
              "keyword": "Given",
              "line": 20,
              "name": "Given I have aws_s3_bucket defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 21,
              "name": "When it has logging",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [
            {
              "line": 18,
              "name": "@noskip_at_line_20"
            }
          ],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "3",
          "keyword": "Scenario",
          "line": 24,
          "name": "Data stored in S3 has versioning enabled",
          "steps": [
            {
              "keyword": "Given",
              "line": 25,
              "name": "Given I have aws_s3_bucket defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 26,
              "name": "Then it must have versioning",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 27,
              "name": "Then it must have enabled",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 28,
              "name": "And its value must be true",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "16",
      "keyword": "Feature",
      "line": 2,
      "name": "S3 related general feature",
      "tags": [
        {
          "line": 1,
          "name": "@s3"
        }
      ],
      "type": "feature",
      "uri": "/var/task/features/S3.feature"
    },
    {
      "description": "Data stored in SNS topic must be encrypted\nrelated resources: aws_sns_topic",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 6,
          "name": "Data stored in SNS topic must be encrypted",
          "steps": [
            {
              "keyword": "Given",
              "line": 7,
              "name": "Given I have aws_sns_topic defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 8,
              "name": "Then it must contain kms_master_key_id",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 9,
              "name": "And its value must not be null",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "17",
      "keyword": "Feature",
      "line": 1,
      "name": "SNS related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/SNS.feature"
    },
    {
      "description": "Data stored must be encrypted\nrelated resources: aws_sqs_queue",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 6,
          "name": "Data stored must be encrypted",
          "steps": [
            {
              "keyword": "Given",
              "line": 7,
              "name": "Given I have aws_sqs_queue defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 8,
              "name": "Then it must have kms_master_key_id",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 9,
              "name": "And its value must not be null",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "18",
      "keyword": "Feature",
      "line": 1,
      "name": "SQS related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/SQS.feature"
    },
    {
      "description": "Data stored must be encrypted at rest\nrelated resources: aws_sagemaker_notebook_instance",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 6,
          "name": "Data stored must be encrypted at rest",
          "steps": [
            {
              "keyword": "Given",
              "line": 7,
              "name": "Given I have aws_sagemaker_notebook_instance defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 8,
              "name": "Then it must have kms_key_id",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 9,
              "name": "And its value must not be null",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "19",
      "keyword": "Feature",
      "line": 1,
      "name": "Sagemaker related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/Sagemaker.feature"
    },
    {
      "description": "Every security group rule must have a description\nNo security group rule allow ingress from 0.0.0.0:0 to port 22/3389\nEvery security group must have a description\nNo security group allow ingress from 0.0.0.0:0 to port 22/3389\nrelated resources: aws_security_group, aws_security_group_rule",
      "elements": [
        {
          "description": "",
          "id": "1",
          "keyword": "Scenario",
          "line": 11,
          "name": "Every security group rule must have a description",
          "steps": [
            {
              "keyword": "Given",
              "line": 12,
              "name": "Given I have aws_security_group_rule defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 13,
              "name": "Then it must have description",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 14,
              "name": "And its value must not be null",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "2",
          "keyword": "Scenario",
          "line": 17,
          "name": "No security group rule allow ingress from 0.0.0.0:0 to port 22",
          "steps": [
            {
              "keyword": "Given",
              "line": 18,
              "name": "Given I have aws_security_group_rule defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 19,
              "name": "When its type is ingress",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 20,
              "name": "And its to_port is 22",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 21,
              "name": "Then it must contain cidr_blocks",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 22,
              "name": "And it must not contain 0.0.0.0/0",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        },
        {
          "description": "",
          "id": "3",
          "keyword": "Scenario",
          "line": 25,
          "name": "No security group rule allow ingress from 0.0.0.0:0 to port 3389",
          "steps": [
            {
              "keyword": "Given",
              "line": 26,
              "name": "Given I have aws_security_group_rule defined",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "When",
              "line": 27,
              "name": "When its type is ingress",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 28,
              "name": "And its to_port is 3389",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "Then",
              "line": 29,
              "name": "Then it must contain cidr_blocks",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            },
            {
              "keyword": "And",
              "line": 30,
              "name": "And it must not contain \"0.0.0.0/0\"",
              "result": {
                "duration": 0,
                "status": "pending"
              }
            }
          ],
          "tags": [],
          "type": "scenario"
        }
      ],
      "id": "20",
      "keyword": "Feature",
      "line": 1,
      "name": "VPC related general feature",
      "tags": [],
      "type": "feature",
      "uri": "/var/task/features/VPC.feature"
    }
  ],
  "summary": {
    "passed_step_count": 0,
    "failed_step_count": 164,
    "skipped_step_count": 0,
    "overall_status": "Failed"
  }
}
```





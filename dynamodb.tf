#************************************************************************************
#*  Template created by Brian Ruter - drum4ever71@aol.com
#   -- Sample to build a simpleDynamo DB Table
#************************************************************************************ 
provider "aws" {
region = "${var.AWS_REGION}"
}
################################
# Create DynamoDb table        #
################################
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "OrderTable"
#  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "UserId"
  range_key      = "OrderNumber"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "OrderNumber"
    type = "S"
  }

   attribute {
    name = "Item"
    type = "S"
  }
  
  attribute {
    name = "Amount"
    type = "N"
  }
  

  ttl {
    attribute_name = "TTL"
    enabled        = true
  }
  
  global_secondary_index {
    name               = "ItemIndex"
    hash_key           = "Item"
    range_key          = "Amount"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "INCLUDE"
    non_key_attributes = ["UserId"]
  }

  tags = {
    Name        = "Order Table"
    Environment = "${var.env}"
  }
}


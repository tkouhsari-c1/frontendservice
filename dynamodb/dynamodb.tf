provider "aws" {
  region = "us-east-1"  # specify the AWS region
}

resource "aws_dynamodb_table" "my_table" {
  name           = "${var.table_name_base}-table"
  billing_mode   = "PROVISIONED"  # can be "PAY_PER_REQUEST" for on-demand mode
  read_capacity  = 5              # read capacity for PROVISIONED mode
  write_capacity = 5              # write capacity for PROVISIONED mode
  hash_key       = "partition_key"  # partition key (also called hash key)

  # Optional: sort key (also called range key)
  range_key = "sort_key"

  # Define the partition and sort key attributes
  attribute {
    name = "partition_key"
    type = "S"  # String type; can be "S" for String, "N" for Number, or "B" for Binary
  }

  attribute {
    name = "sort_key"
    type = "N"  # Number type
  }

  # Optional: Define a global secondary index
  global_secondary_index {
    name            = "SecondaryIndex"
    hash_key        = "secondary_partition_key"
    range_key       = "secondary_sort_key"
    projection_type = "ALL"

    read_capacity  = 5
    write_capacity = 5
  }

  # Define the secondary index attributes
  attribute {
    name = "secondary_partition_key"
    type = "S"
  }

  attribute {
    name = "secondary_sort_key"
    type = "N"
  }

  tags = {
    Name        = "MyDynamoDBTable"
    Environment = "Production"
  }
}

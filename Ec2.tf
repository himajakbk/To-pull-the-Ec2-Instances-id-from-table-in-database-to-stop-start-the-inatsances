resource "aws_instance" "example" {
  ami           = "ami-0440d3b780d96b29d"  # your AMI ID
  instance_type = "t2.micro"
  # other instance configurations like subnet, security group, etc.
  # ...
}
resource "aws_instance" "main" {
  ami           = "ami-0440d3b780d96b29d"  # your AMI ID
  instance_type = "t2.micro"
  # other instance configurations like subnet, security group, etc.
  # ...

  lifecycle {
    prevent_destroy = true

    # Stop the instance before updating or destroying it
    # This ensures the instance is stopped rather than terminated
    # To change this behavior, set "ignore_changes" to ["instance_state"]
    # ignore_changes = [instance_state]

    # Stop the instance when Terraform is used to destroy or update it
    # This is necessary to prevent costs when the instance is not needed
   
  }
}
resource "aws_instance" "provider" {
  ami           = "ami-0440d3b780d96b29d"  # your AMI ID
  instance_type = "t2.micro"
  # other instance configurations like subnet, security group, etc.
  # ...

  lifecycle {
    prevent_destroy = true

    # Stop the instance before updating or destroying it
    # This ensures the instance is stopped rather than terminated
    # To change this behavior, set "ignore_changes" to ["instance_state"]
    # ignore_changes = [instance_state]

    # Stop the instance when Terraform is used to destroy or update it
    # This is necessary to prevent costs when the instance is not needed
    
  }
}

# To start the instance explicitly
resource "null_resource" "start_instance" {
  provisioner "local-exec" {
    command = "aws ec2 start-instances --instance-ids ${aws_instance.example.id}"
  }
}

# To stop the instance explicitly
resource "null_resource" "stop_instance" {
  provisioner "local-exec" {
    command = "aws ec2 stop-instances --instance-ids ${aws_instance.example.id}"
  
  }
}

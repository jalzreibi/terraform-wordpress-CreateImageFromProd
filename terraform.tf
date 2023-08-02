resource "aws_instance" "wordpress" {
  ami           = "ami-040e8afbcea1c41d8"
  instance_type = "t2.micro"
  tags = {
    "Name"       = "wordpress-server1-blue-prod"
    "deployment" = "blue"
  }
  tags_all = {
    "Name"       = "wordpress-server1-blue-prod"
    "deployment" = "blue"
  }
  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_instance" "mariadb" {
  ami           = "ami-040e8afbcea1c41d8"
  instance_type = "t2.micro"
  tags = {
    "Name"       = "mariadb-server1-blue-prod"
    "deployment" = "blue"
  }
  tags_all = {
    "Name"       = "mariadb-server1-blue-prod"
    "deployment" = "blue"
  }
  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_ami_from_instance" "wordpress-ami" {
  name               = "terraform-wordpress-ami"
  source_instance_id = aws_instance.wordpress.id
  snapshot_without_reboot = true
  tags = {
    Name = "terraform-wordpress-ami"
  }
}
resource "aws_ami_from_instance" "mariadb-ami" {
  name               = "terraform-mariadb-ami"
  source_instance_id = aws_instance.mariadb.id
  snapshot_without_reboot = true
  tags = {
    Name = "terraform-mariadb-ami"
  }
}
resource "aws_ebs_snapshot" "wordpress_data_snapshot" {
  volume_id = element(aws_instance.wordpress.ebs_block_device.*.volume_id, 0)
  tags = {
    Name = "terraform-backup-wordpress-data"
  }
}
resource "aws_ebs_snapshot" "mariadb_data_snapshot" {
  volume_id = element(aws_instance.mariadb.ebs_block_device.*.volume_id, 0)
  tags = {
    Name = "terraform-backup-mariadb-data"
  }
}

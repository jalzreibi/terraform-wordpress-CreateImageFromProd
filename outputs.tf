output "mariadb_ami_id" {
  value = aws_ami_from_instance.mariadb-ami.id
}
output "wordpress_ami_id" {
  value = aws_ami_from_instance.wordpress-ami.id
}
output "wordpress_data_snapshot_id" {
  value = aws_ebs_snapshot.wordpress_data_snapshot.id
}
output "maraiadb_data_snapshot_id" {
  value = aws_ebs_snapshot.mariadb_data_snapshot.id
}

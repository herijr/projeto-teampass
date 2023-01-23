resource "aws_db_subnet_group" "default" {
  name       = "${var.project-name}-db-group"
  subnet_ids = [aws_subnet.private01.id, aws_subnet.private02.id, aws_subnet.private03.id, ]
  tags = {
    Name = "mysql-${var.project-name}"
  }
}

resource "aws_db_instance" "this" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.30"
  identifier           = "database-teampass"
  instance_class       = "db.t2.micro"
  db_name              = "db_teampass"
  username             = "admin"
  password             = "senha1234"
  parameter_group_name = "default.mysql8.0"
  availability_zone    = "${var.aws_region}a"
  skip_final_snapshot  = true

  db_subnet_group_name   = aws_db_subnet_group.default.id
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
}
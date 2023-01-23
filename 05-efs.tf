resource "aws_efs_file_system" "this" {
  encrypted        = true
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  tags = {
    Name = "${var.project-name}"
  }
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  lifecycle_policy {
    transition_to_primary_storage_class = "AFTER_1_ACCESS"
  }
}

resource "aws_efs_mount_target" "mount_1a" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = aws_subnet.private01.id
  security_groups = [aws_security_group.sg_efs.id]
}

resource "aws_efs_mount_target" "mount_1b" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = aws_subnet.private02.id
  security_groups = [aws_security_group.sg_efs.id]
}

resource "aws_efs_mount_target" "mount_1c" {
  file_system_id  = aws_efs_file_system.this.id
  subnet_id       = aws_subnet.private03.id
  security_groups = [aws_security_group.sg_efs.id]
}

resource "aws_efs_access_point" "files" {
  file_system_id = aws_efs_file_system.this.id
  root_directory {
    path = "/files"
    creation_info {
      owner_uid   = "33"
      owner_gid   = "33"
      permissions = "0755"
    }
  }
}

resource "aws_efs_access_point" "upload" {
  file_system_id = aws_efs_file_system.this.id
  root_directory {
    path = "/upload"
    creation_info {
      owner_uid   = "33"
      owner_gid   = "33"
      permissions = "0755"
    }
  }
}

resource "aws_efs_access_point" "secret" {
  file_system_id = aws_efs_file_system.this.id
  root_directory {
    path = "/secret"
    creation_info {
      owner_uid   = "33"
      owner_gid   = "33"
      permissions = "0755"
    }
  }
}

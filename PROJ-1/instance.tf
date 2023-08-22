resource "aws_key_pair" "mykey" {
  key_name   = "dove-key"
  public_key = file("dove-key.pub")
}
resource "aws_instance" "dove-inst" {
  subnet_id              = aws_subnet.mysub-pub1.id
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE
  key_name               = "dove-key"
  vpc_security_group_ids = [aws_security_group.my-sec-grp.id]

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }
  connection {
    user        = "ec2-user"
    private_key = file("dove-key")
    host        = self.public_ip
  }
  tags = {
    Name    = "Terra-Instance"
    Project = "Dove"
  }
}
resource "aws_ebs_volume" "myebs" {
  availability_zone = "us-east-1a"
  size              = 40

  tags = {
    Name = "terra-volume"
  }
}
resource "aws_volume_attachment" "myebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.myebs.id
  instance_id = aws_instance.dove-inst.id
}
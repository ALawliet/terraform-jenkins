resource "aws_route53_zone" "yoko_zone" {
  name = "yokotheshibe.com"
}

resource "aws_route53_record" "jenkins_record" {
  zone_id = "${aws_route53_zone.yokozone.zone_id}"
  name    = "jenkins.yokotheshibe.com"
  type    = "A"
  ttl     = "300"
  records = ["54.196.220.82"]
}

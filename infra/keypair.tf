resource "aws_key_pair" "mykeypair" {
  key_name   = "mykeypair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8Bd6BIYPIgiWCVYDBSQIzBzgzzbcaIm+QAxnpn3WcpGeZi3rmiVMIApQfafr0cs66q8AUH466SXr8ppLmgnCuRSP8VYADWnu5Dieigs/CD+J6wOKLY4kdjlKuFm1ecoS4TJipox672kx1NOSybrj5wLbpgqi0QcHKii/MKxsHDS62YOSAF4TGkST5rE8SSvvkrROjZGSnmlyuaTXSWCTsd7JKINHfHsrRWNfc0enwISyehiHDgu7M7Q345agME5gj3bCzuwvFD3QE5c7v22SpDPez0Jm+T0lD9bTepeDfL+UMyyzlWlV7xgAydC6mbaB0+KdkDzATr/hv1s8own+mULVNawTL8EyZ0eby/i60KQp83NFX4n8bBTWpAkrQ05/ELKRjaCyE8qoExCtxq8EBiLZCzUsQ2WKPX3/I3AnwS9+Ul20eoikwJN2F8OAmAsvDpDhEUDOog2KItWpwo/QgdUzkASHyL2IcGqbkN/qxF5rCAR8H/0r0pp4gg27te9k= andres.castrillonv@LATAM-8KSDDL3"
}

# resource "aws_key_pair" "kp-rampupACV" {
#   key_name   = "kp-rampupACV"
#   public_key = file("../deploy/kp-rampupACV")
# }
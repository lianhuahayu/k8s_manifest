 #!/bin/bash
  sudo hostnamectl set-hostname minikube-master
  sudo sh -c "echo '127.0.0.1 minikube-master' >> /etc/hosts"
  sudo apt-get -y update
  sudo apt install -y qemu qemu-kvm libvirt-daemon libvirt-clients bridge-utils virt-manager
  sudo apt-get install -y socat
  sudo apt-get install -y conntrack
  sudo curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker ubuntu
  sudo systemctl start docker
  sudo apt-get -y install wget
  sudo wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo chmod +x minikube-linux-amd64
  sudo mv minikube-linux-amd64 /usr/bin/minikube
  sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
  sudo chmod +x kubectl
  sudo mv kubectl  /usr/bin/
  sudo echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
  #sudo chmod 666 /var/run/docker.sock
  sudo systemctl enable docker.service
  minikube status

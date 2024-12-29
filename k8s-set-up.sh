lsmod | grep br_netfilter
sudo modprobe br_netfilter
sudo modprobe overlay
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables =1
net.bridge.bridge-nf-call-ip6tables =1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system
wget https://github.com/containerd/containerd/releases/download/v1.6.8/containerd-1.6.8-linux-amd64.tar.gz
sudo tar Cxvf /usr/local contanerd-1.6.8-linux-amd64.tar.gz
sudo tar Cxvf /usr/local containerd-1.6.8-linux-amd64.tar.gz
sudo wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc
sudo mkdir -p /opt/cni/bin
sudo wget https://github.com/containernetworking/plugins/releases/download/v1.3.0/cni-plugins-linux-amd64-v1.3.0.tgz
sudo tar Cxvf /opt/cni/bin cni-plugins-linux-amd64-v1.3.0.tgz 
sudo apt update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://donwload.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update 
sudo apt install containerd.io -y
sudo mkdir -p /etc/containerd
sudo su
containerd config default>/etc/containerd/config.toml # this command will create default config.toml
exit
sudo systemctl restart containerd
sudo systemctl enable containerd

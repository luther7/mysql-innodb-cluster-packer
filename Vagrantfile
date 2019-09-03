box = ENV["VAGRANT_BOX"] || "centos-7"

$set_consul_env = <<-SCRIPT
sudo mkdir -p /var/run/consul
sudo echo "CONSUL_ADVERTISE=\"-advertise=${1}\"" > /var/run/consul/env
sudo echo "CONSUL_BOOTSTRAP_EXPECT=\"-bootstrap-expect=${2}\"" >> /var/run/consul/env
sudo chown -R consul:consul /var/run/consul
sudo iptables -F
sudo systemctl restart consul
# TODO This should not be needed - the cluster should automatically bootstrap.
sudo consul join 10.0.0.2
sudo consul join 10.0.0.3
sudo consul join 10.0.0.4
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "mysql-8-#{box}"
  config.vm.synced_folder ".", "/vagrant"
  config.ssh.username = "packer"
  config.ssh.password = "packer"
  config.ssh.insert_key = false

  (1..3).each do |i|
    config.vm.define "mysql-#{i}" do |node|
      ip = "10.0.0.#{i+1}"
      node.vm.hostname = "mysql-#{i}"
      node.vm.network :private_network, ip: ip
      node.vm.provider :node do |vm|
        vm.gui    = false
        vm.cpus   = 1
        vm.memory = 512
      end
      node.vm.provision "shell" do |script|
        script.inline = $set_consul_env
        script.args   = [ip, "3"]
      end
    end
  end
end

box = ENV["VAGRANT_BOX"] || "centos-7"

$set_consul_env = <<-SCRIPT
cat > /var/run/consul/env <<EOF
CONSUL_ADVERTISE="-advertise=${1}"
CONSUL_BOOTSTRAP_EXPECT="-bootstrap-expect=${2}"
EOF
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "mysql-8-#{box}"
  config.vm.synced_folder ".", "/vagrant"
  config.ssh.username = "packer"
  config.ssh.password = "packer"
  config.ssh.insert_key = false
  (1..3).each do |n|
    config.vm.define "mysql-#{n}" do |node|
      node.vm.network :private_network, ip: "10.0.0.#{n+1}"
      config.vm.provider :node do |vm|
        vm.gui    = false
        vm.cpus   = 1
        vm.memory = 512
      end
      #config.vm.provision "shell" do |script|
      #  script.inline = $set_consul_env
      #  script.args   = ["10.0.0.#{n+1}", "3"]
      #end
    end
  end
end

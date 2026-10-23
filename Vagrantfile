Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-vagrant.box"
  config.vm.box_check_update = false

  nodes = [
    {
      name: "ansible-control",
      ip: "192.168.56.10",
      mem: 1024
    },
    {
      name: "web1",
      ip: "192.168.56.11",
      mem: 512,
      password_ssh: true
    },
    {
      name: "db1",
      ip: "192.168.56.12",
      mem: 512,
      password_ssh: true
    },
  ]

  nodes.each do |n|
    config.vm.define n[:name] do |node|
      node.vm.hostname = n[:name]
      node.vm.network "private_network", ip: n[:ip]
      node.vm.provider "virtualbox" do |vb|
        vb.name = n[:name]
        vb.memory = n[:mem]
        vb.cpus = 1
      end

      if n[:password_ssh]
        node.vm.provision "shell", name: "enable-password-ssh", path: "ssh.sh"
      end
    end
  end
end

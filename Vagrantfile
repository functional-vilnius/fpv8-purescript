Vagrant.configure(2) do |config|
	config.vm.box = "ubuntu/trusty64"
	config.vm.synced_folder "./", "/home/vagrant/code"
	config.vm.provision "shell", path: "provision.sh"
	config.vm.provider "virtualbox" do |v|
		v.memory = 2048
	end
end


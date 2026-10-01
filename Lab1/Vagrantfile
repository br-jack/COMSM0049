Vagrant.configure("2") do |config|
  config.vm.box = "generic/debian12"
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision "shell", inline: "sudo apt-get update --yes"
  config.vm.provision "shell", inline: "sudo apt-get install --yes strace nasm binutils build-essential"
end

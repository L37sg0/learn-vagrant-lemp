Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.provision :shell,
      path: "bootstrap.sh"

  config.vm.network :forwarded_port,
      guest: 80,
      host: 8080

  config.vm.synced_folder ".", "/var/www",
      owner: "vagrant",
      group: "www-data",
      mount_options: ["dmode=775", "fmode=664"]
  config.vm.synced_folder "./etc/nginx/sites-available", "/etc/nginx/sites-available",
      owner: "vagrant",
      group: "root"
  config.vm.synced_folder "./etc/php/custom", "/etc/php/8.1/fpm/conf.d/custom",
      owner: "vagrant",
      group: "root"
  config.vm.synced_folder "./etc/mysql/custom", "/etc/mysql/conf.d/custom",
      owner: "vagrant",
      group: "root"
end
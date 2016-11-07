#
# Cookbook Name:: chef-xhprof-gui
# Recipe:: xhgui
#
# Copyright 2012, Alistair Stead
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

apt_package ['mongodb', 'php5-dev', 'php5-mcrypt', 'libcurl4-openssl-dev', 'pkg-config', 'libssl-dev', 'libsslcommon2-dev', 'libpcre3-dev'] do
    action :install
end

php_pear "mongodb" do
    action :install
end

template "#{node['php']['ext_conf_dir']}/mcrypt.ini" do
  mode "0644"
  action :create_if_missing
end

execute "enable-mcrypt" do
    command "php5enmod mcrypt"
end

git node['xhprof']['install_path'] do
  repository "git://github.com/perftools/xhgui.git"
  revision "master"
  action :sync
end

web_app node['xhprof']['hostname'] do
  server_name node['xhprof']['hostname']
  apache node['apache']
  server_aliases [node['fqdn']]
  docroot "#{node['xhprof']['install_path']}/webroot"
end

# Install Graphviz for use with xhprof-gui graphs.
package "graphviz"

# Run the install script
execute "install-xhgui" do
  cwd "#{node['xhprof']['install_path']}"
  command "/usr/bin/env php install.php"
end

template "#{node['xhprof']['install_path']}/config/config.default.php" do
  source "config.default.php.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
    :params => node['xhprof'],
    :database => node['xhprof']['db']
  )
end

log " You can now access XHGui at #{node['xhprof']['hostname']} #{node['fqdn']}"

#
# Cookbook Name:: chef-xhprof-gui
# Recipe:: xhprof
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


apt_package ['php5-dev', 'php5-mcrypt', 'libcurl4-openssl-dev', 'pkg-config', 'libssl-dev', 'libsslcommon2-dev', 'libpcre3-dev'] do
    action :install
end

template "#{node['php']['ext_conf_dir']}/mcrypt.ini" do
  mode "0644"
  action :create_if_missing
end

execute "enable-mcrypt" do
    command "php5enmod mcrypt"
end

php_pear "xhprof" do
    preferred_state "beta"
    action :install
end

template "#{node['php']['ext_conf_dir']}/xhprof.ini" do
  mode "0644"
  action :create_if_missing
end

execute "enable-xhprof" do
    command "php5enmod xhprof"
end



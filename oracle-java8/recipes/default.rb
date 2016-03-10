#
# Cookbook Name:: oracle-java
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
# Cookbook Name:: java8
# Recipe:: default
#

#apt_repository "webupd8team" do
#  uri "ppa:webupd8team/java"
#  components ['main']
#  distribution node['lsb']['codename']
#  keyserver "keyserver.ubuntu.com"
#  key "EEA14886"
#  deb_src true
#end
package "python-software-properties" do
      action :install
        options "--force-yes"
end

execute "install repo" do
      command "add-apt-repository -y ppa:webupd8team/java"
end

execute "update" do
      command "apt-get update"
end

# could be improved to run only on update
execute "accept-license" do
      command "echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections"
end

package "oracle-java8-installer" do
      action :install
        options "--force-yes"
end

package "oracle-java8-set-default" do
      action :install
        options "--force-yes"
end

cookbook_file '/usr/lib/jvm/java-8-oracle/jre/lib/security/US_export_policy.jar' do
  source 'US_export_policy.jar'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/usr/lib/jvm/java-8-oracle/jre/lib/security/local_policy.jar' do
  source 'local_policy.jar'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

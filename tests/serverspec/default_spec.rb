require "spec_helper"
require "serverspec"

package = "mysql"
service = "mysql-server"
config_dir = "/etc/mysql"
# user    = "mysql"
# group   = "mysql"
ports = [3306]
default_user = "root"
default_group = "root"
default_random_password_file = nil
databases = %w[my_database other_database]
database_users = %w[me root]

case os[:family]
when "freebsd"
  package = "mysql57-server"
  config_dir = "/usr/local/etc/mysql"
  default_group = "wheel"
  default_random_password_file = "/root/.mysql_secret"
end
config = "#{config_dir}/my.cnf"

describe package(package) do
  it { should be_installed }
end

describe file(config) do
  it { should exist }
  it { should be_file }
  it { should be_mode 644 }
  its(:content) { should match Regexp.escape("Managed by ansible") }
end

case os[:family]
when "freebsd"
  describe file("/etc/rc.conf.d/mysql_server") do
    it { should exist }
    it { should be_file }
    it { should be_mode 644 }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
  end
end

if default_random_password_file
  describe file default_random_password_file do
    it { should_not exist }
  end
end

describe file "/root/.my.cnf" do
  it { should exist }
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by default_user }
  it { should be_grouped_into default_group }
  its(:content) { should match(/Managed by ansible/) }
  its(:content) { should match(/# mysql_extra_my_cnf_config/) }
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command "mysql --user=root --execute 'SELECT 42;'" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
  its(:stdout) { should match(/^42$/) }
end

describe command "mysql --user=root --execute 'SHOW DATABASES;'" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
  databases.each do |name|
    its(:stdout) { should match(/^#{name}$/) }
  end
end

describe command "mysql --user=root --execute 'SELECT User FROM mysql.user;'" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
  database_users.each do |name|
    its(:stdout) { should match(/^#{name}$/) }
  end
end

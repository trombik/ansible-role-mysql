require "spec_helper"
require "serverspec"

package = "mysql"
service = "mysql"
config  = "/etc/mysql/mysql.conf"
user    = "mysql"
group   = "mysql"
ports   = [PORTS]
log_dir = "/var/log/mysql"
db_dir  = "/var/lib/mysql"

case os[:family]
when "freebsd"
  config = "/usr/local/etc/mysql.conf"
  db_dir = "/var/db/mysql"
end

describe package(package) do
  it { should be_installed }
end

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape("mysql") }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(db_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

case os[:family]
when "freebsd"
  describe file("/etc/rc.conf.d/mysql") do
    it { should be_file }
  end
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

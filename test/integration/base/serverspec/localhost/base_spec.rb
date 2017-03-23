require 'spec_helper'

# Check if hostname is properly set
describe command('hostname') do
    its(:stdout) { should match /baseDefault/}
end

# Check if hostname has been successfully added to hosts file
describe file('/etc/hosts') do
    it { should contain '127.0.0.1 baseDefault'}
end

# Check if the Environment has been set to /etc/environment
describe file('/etc/environment') do
    it { should contain 'ENVIRONMENT="local"'}
end

# Check if groups have been created correctly
describe group('group1') do
    it { should exist }
    it { should_not have_gid 1010}
end

describe group('group2') do
    it { should exist }
    it { should have_gid 1010}
end

describe group('user1') do
    it { should exist }
end

describe user('user1') do
    it { should exist }
    it { should belong_to_primary_group 'user1' }
    it { should belong_to_group 'group1' }
    it { should belong_to_group 'group2' }
end

describe file('/etc/sudoers.d/10-local-sudoers') do
    it { should exist }
    it { should contain '%group2 ALL=(ALL:ALL) ALL' }
    it { should contain '%group3 ALL=(ALL:ALL) NOPASSWD: ALL' }
    # it { should match /%group\d+\s+ALL=\(ALL:ALL\)\s+(NOPASSWD:\s+)?ALL/ }
end

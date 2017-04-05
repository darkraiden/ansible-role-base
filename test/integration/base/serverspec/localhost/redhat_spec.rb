require 'spec_helper'

if os[:family] == 'redhat'

    describe package('epel-release') do
        it { should be_installed }
    end

    if os[:release].to_i > 6

        describe file('/etc/locale.conf') do
            its(:content) { should match /LANG=en_GB\.UTF-8/ }
        end

    end

    describe file('/etc/localtime') do
        it { should be_linked_to '/usr/share/zoneinfo/UTC' }
    end

    describe package('ntp') do
        it { should be_installed }
    end

    describe file('/etc/sysconfig/selinux') do
        its(:content) { should match /^SELINUX=disabled/ }
    end

end

require './ip.rb'

describe 'IP::Mask' do
  subject { IP.mask('255.255.254.0') }
  it { should eq IP.mask('255.255.254.0') }
  it { should_not eq IP.mask('255.255.255.0') }
  its(:hosts) { should eq 510 }
  its(:cidr) { should eq 23 }
  its(:bitmask) { should eq 0b11111111111111111111111000000000 }
  its(:wildcard) { should eq 0b111111111 }
  its(:to_s) { should eq '255.255.254.0' }
end

describe 'IP::IPv4' do
  subject { IP.address('192.168.22.2', '255.255.255.252') }
  it { should eq IP.address('192.168.22.2', '255.255.255.252') }
  it { should_not eq IP.address('192.168.22.2', '255.255.255.0') }
  it { should_not eq IP.address('192.168.23.2', '255.255.255.252') }

  its(:address) { should eq 3232241154 }
  its(:to_s) { should eq '192.168.22.2/255.255.255.252' }
  its(:octets) { should eq [192, 168, 22, 2] }
  its(:mask) { should eq IP.mask('255.255.255.252') }
  its(:network) { should eq IP.address('192.168.22.0', '255.255.255.252') }
  its(:broadcast) { should eq IP.address('192.168.22.3', '255.255.255.252') }
end

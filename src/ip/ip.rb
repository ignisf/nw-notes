module IP
  def self.address(ip, mask = '255.255.255.255')
    IPv4.new parse_dot_decimal(ip), mask(mask)
  end

  def self.mask(mask)
    Mask.new parse_dot_decimal mask
  end

  def self.parse_dot_decimal(string)
    octets = string.split('.').map(&:to_i)
    octets.inject(0) { |integer, octet| (integer << 8) + octet }
  end

  class Address
    attr_accessor :address

    def initialize(address)
      @address = address
    end

    def to_s
      octets.join '.'
    end

    def octets
      Array.new(4) { |octet| @address >> octet * 8 & 0xff }.reverse
    end

    def ==(other)
      @address == other.address
    end
  end

  class Mask < Address
    alias :bitmask :address

    def cidr
      result = 0
      (@address.size * 8).times do |bit|
        result += @address[bit]
      end
      result
    end

    def hosts
      wildcard - 1
    end

    def wildcard
      ~@address & 0xffffffff
    end
  end

  class IPv4 < Address
    attr_accessor :mask

    def initialize(address, mask)
      super address
      @mask = mask
    end

    def to_s
      super + '/' + @mask.to_s
    end

    def ==(other)
      super and @mask == other.mask
    end

    def network
      IPv4.new address & mask.bitmask, mask
    end

    def broadcast
      IPv4.new address | mask.wildcard, mask
    end
  end
end

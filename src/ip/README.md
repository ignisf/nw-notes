## Примерен IPv4 калкулатор

	[1] pry(main)> require './ip'
    [2] pry(main)> IP.address '192.168.22.1', '255.255.255.128'
    => 192.168.22.1/255.255.255.128
    [3] pry(main)> ip = IP.address '192.168.22.1', '255.255.255.128'
    => 192.168.22.1/255.255.255.128
    [4] pry(main)> ip.mask
    => 255.255.255.128
    [5] pry(main)> ip.network
    => 192.168.22.0/255.255.255.128
    [6] pry(main)> ip.broadcast
    => 192.168.22.127/255.255.255.128
    [7] pry(main)>
	[7] pry(main)> ip.mask.hosts
	=> 126

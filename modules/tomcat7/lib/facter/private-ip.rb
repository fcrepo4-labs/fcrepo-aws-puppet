Facter.add("ip_address") do
  setcode do
    Facter::Util::Resolution.exec('/usr/bin/curl http://169.254.169.254/latest/meta-data/local-ipv4')
  end
end

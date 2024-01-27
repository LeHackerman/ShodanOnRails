# frozen_string_literal: true

require 'shodanz'

class ShodanAPI
  def initialize
    @@client = Shodanz.client.new
  end

  def host_query_raw(query)
    @@client.host(query)
  end

  def host_query_ports(query)
    @@client.host(query)['ports']
  end
end

require 'net/http'

# angle lever 158 ->  60 repos 158
# rottion 20 -> 160 repos 90
# couide 20 -> 125 repos 20
# main 0 -> 180
# sur 3 charvec - entre. - temps en millisecond sur 4 chiffres - 3 char etapes.

class Doing
  BRAS="192.168.2.178"

  def self.man_hello
    call_bras("110-090-100-000-2000-70")
    call_bras("110-020-110-180-2000-70")
  end

  def self.hello
    call_bras("/p")
  end

  def self.reset
    call_bras("/r")
  end

  private

  def self.call_bras(uri)
    Net::HTTP.get("#{BRAS}", uri)
  end
end


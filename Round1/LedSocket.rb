require 'socket'

class LedSocket < TCPSocket

  def update()
    write("UPDATE\n")
  end

  def sendSingle(lightid, led)
    write("SET_SINGLE #{lightid} #{led[0]},#{led[1]},#{led[2]},#{led[3]},\n")
  end

  def sendAll(led)
    write("SET_ALL #{led[0]},#{led[1]},#{led[2]},#{led[3]},\n")
  end

  def sendMulti(led)
    led.size.times do |i|
      sendSingle(i, led[i])
    end
  end

end

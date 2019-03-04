require "xmodem"
# https://www.rubydoc.info/gems/serialport/SerialPort
require "serialport"
require "pry"

port_name   = ENV.fetch("PORT", "/dev/ttyUSB0")
options     = {
  baud:         ENV.fetch("BAUD", "9600").to_i,
  data_bits:    8,
  stop_bits:    1,
  parity:       SerialPort::NONE,
  flow_control: SerialPort::HARD
}

SerialPort.open(port_name, options) do |serial_port|
  file        = File.new(ENV.fetch("FILE"),"rb")
  puts "'SYSTEM OK' on distant end is a good thing."
  puts "If you don't see that, your serial config is broke."
  serial_port.puts("SYSTEM OK")
  sleep 2
  XMODEM::send(serial_port, file)
  puts "=== Done!"
  file.close
end

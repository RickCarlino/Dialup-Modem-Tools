require "xmodem"
# https://www.rubydoc.info/gems/serialport/SerialPort
require "serialport"
require "pry"

port_name   = ENV.fetch("PORT", "/dev/ttyUSB0")
options     = {
  baud:         9600,
  data_bits:    8,
  stop_bits:    1,
  parity:       SerialPort::NONE,
  flow_control: SerialPort::HARD
}
SerialPort.open(port_name, options) do |serial_port|
  file        = File.new(ENV.fetch("FILE"),"rb")
  puts "If you see 'SYSTEM OK' on the other end, you are properly configured."
  serial_port.puts("SYSTEM OK")
  sleep 2
  XMODEM::send(serial_port, file)
  puts "=== Done!"
  file.close
end

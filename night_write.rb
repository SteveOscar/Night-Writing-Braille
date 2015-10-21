require 'pry'
class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end

class FileWriter
  def output
    filename = ARGV[1]
    File.open(filename, "w")
  end
end

class NightWriter
  attr_reader :reader, :writer, :braille, :dots

  def initialize
    @reader = FileReader.new
    @writer = FileWriter.new
    @text = @reader
    @braille = ''
    @dots = {"a" => ['0.', '..', '..'], "b" => ['0.', '0.', '..'], "c" => ['00', '..', '..'],
            "d" => ['00', '.0', '..'], "e" => ['0.', '.0', '..'], "f" => ['00', '0.', '..'],
            "g" => ['00', '00', '..'], "h" => ['0.', '00', '..'], "i" => ['.0', '0.', '..'],
            "j" => ['.0', '00', '..'], "k" => ['0.', '..', '0.'], "l" => ['0.', '0.', '0.'],
            "m" => ['00', '..', '0.'], "n" => ['00', '.0', '0.'], "o" => ['0.', '.0', '0.'],
            "p" => ['00', '0.', '0.'], "q" => ['00', '00', '0.'], "r" => ['0.', '00', '0.'],
            "s" => ['.0', '0.', '0.'], "t" => ['.0', '00', '0.'], "u" => ['0.', '..', '00'],
            "v" => ['0.', '0.', '00'], "w" => ['.0', '00', '.0'], "x" => ['00', '..', '00'],
            "y" => ['00', '.0', '00'], "z" => ['0.', '.0', '00'], " " => ['..', '..', '..'],
            "?" => ['..', '00', '0.'], "'" => ['..', '..', '0.'], "," => ['..', '0.', '..'],
            "!" => ['..', '..', '00'], "." => ['..', '00', '.0'], "-" => ['..', '0.', '00'],
            }
  end

  def encode_to_braille(file)
    line0, line1, line2 = '', '', ''
    file.each_char { |char| line0 << @dots[char][0] }
    file.each_char { |char| line1 << @dots[char][1] }
    file.each_char { |char| line2 << @dots[char][2] }
    @braille << line0 + "\n" + line1 + "\n" + line2 + "\n"
    # write_file(line0, line1, line2)
  end

  def write_file(handle)
    handle.write(@braille)
    puts "Just write a file to #{@handle} that is #{@braille.length / 2} chars long"
  end

end

if __FILE__ == $0
  read_instance = NightWriter.new
  file = read_instance.reader.read
  read_instance.encode_to_braille(file)
  handle = read_instance.writer.output
  read_instance.write_file(handle)
end

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
            "1" => ['0.', '..', '..'], "2" => ['0.', '0.', '..'], "3" => ['00', '..', '..'],
            "4" => ['00', '.0', '..'], "5" => ['0.', '.0', '..'], "6" => ['00', '0.', '..'],
            "7" => ['00', '00', '..'], "8" => ['0.', '00', '..'], "9" => ['.0', '0.', '..'],
            "0" => ['.0', '00', '..'], "^" => ['..', '..', '.0'], "nu" => ['.0', '.0', '00']}
  end

  def write_braille_row(file, line, i)
    j = 0
    until j >= file.length
      line << @dots["^"][i] if file[j] == file[j].upcase && file[j].downcase != file[j]
      if ('0'..'9').include?(file[j])
        line << @dots["nu"][i] unless ('0'..'9').include?(file[j - 1]) && j > 0
        line << @dots[file[j].downcase][i]
        line << @dots[" "][i] unless ('0'..'9').include?(file[j + 1])
      else
        line << @dots[file[j].downcase][i]
      end
      if ('0'..'9').include?(file[j]) && ('a'..'z').include?(file[j + 1])
        line << @dots[" "][i]
      end
      j += 1
    end
    @braille << line + "\n"
  end

  def encode_to_braille(file)
    line0, line1, line2 = '', '', ''
    write_braille_row(file, line0, 0)
    write_braille_row(file, line1, 1)
    write_braille_row(file, line2, 2)
  end

  def write_file(handle)
    handle.write(@braille)
    puts "Just wrote a file to #{@handle} that is #{@braille.length / 2} chars long"
  end
end

if __FILE__ == $0
  read_instance = NightWriter.new
  file = read_instance.reader.read
  read_instance.encode_to_braille(file)
  handle = read_instance.writer.output
  read_instance.write_file(handle)
end

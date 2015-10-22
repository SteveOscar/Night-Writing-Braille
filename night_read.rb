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

class NightReader
  attr_reader :reader, :writer, :dots, :message, :braille_char, :nums

  def initialize
    @reader = FileReader.new
    @writer = FileWriter.new
    @message = ''
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
            "^" => ['..', '..', '.0'], "nu" => ['.0', '.0', '00']}.invert

    @nums = {"1" => ['0.', '..', '..'], "2" => ['0.', '0.', '..'], "3" => ['00', '..', '..'],
             "4" => ['00', '.0', '..'], "5" => ['0.', '.0', '..'], "6" => ['00', '0.', '..'],
             "7" => ['00', '00', '..'], "8" => ['0.', '00', '..'], "9" => ['.0', '0.', '..'],
             "0" => ['.0', '00', '..'], }.invert
  end

  def decode_to_text(file)
    text = file.lines
    i, j, l = 0, 0, (text[0].length / 2)
    until i >= l
      assemble_char(text, j)
      j += 2
      if @braille_char == @dots.key("^")
        @message << (@dots[assemble_char(text, j)]).upcase
        j += 2
        i += 2
      elsif @braille_char == @dots.key("nu")
          @message << (@nums[assemble_char(text, j)])
          j += 2
          i += 2
          loop do
            assemble_char(text, j)
            break if @braille_char == @dots.key(" ") || i >= l
            @message << @nums[@braille_char]
            j += 2
            i += 1
        end
      else
        @message << @dots[@braille_char]
        i += 1
      end
    end
    @message #for tests
  end

  def assemble_char(input_text, counter)
    i = 0
    @braille_char = []
    3.times do
      @braille_char << input_text[i][counter,2]
      i += 1
    end
    @braille_char # for tests
  end

  def write_file(handle)
    handle.write(@message)
    puts "Wrote a file to #{@handle} that is #{@message.length} chars long"
  end

end

if __FILE__ == $0
  read_instance = NightReader.new
  file = read_instance.reader.read
  read_instance.decode_to_text(file)
  handle = read_instance.writer.output
  read_instance.write_file(handle)
end

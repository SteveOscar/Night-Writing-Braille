require 'pry'
class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end

class NightReader
  attr_reader :reader, :writer, :text, :dots, :lines, :message

  def initialize
    @reader = FileReader.new
    @text = @reader
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
            }.invert
  end

  def decode_to_text(file)
    text = file.lines
    l = text[0].length / 2 # l determines loops through braille file
    message = ''
    j = 0
    l.times do
      braille_char = []
      i = 0
      3.times do
        braille_char << text[i][j,2]
        i += 1
      end
      j += 2
      found = @dots.has_key?(braille_char)
      @message << @dots[braille_char]
    end
  output_file
  end


  def output_file
    out = File.open("reader_output.txt", "w")
    out.write(@message)
    puts "Created filename containing #{@message.length} characters"
    @message
  end

end

if __FILE__ == $0
  night = NightReader.new
  file = night.reader.read
  night.decode_to_text(file)
end

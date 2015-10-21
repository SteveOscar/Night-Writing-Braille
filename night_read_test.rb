require 'pry'
require 'minitest'
require 'minitest/autorun'
require './night_read'

class NightReaderTest < Minitest::Test
  def test_decoding_letters
    braille = "0.0.00\n..0...\n......\n"
    night = NightReader.new
    message = night.decode_to_text(braille)
    assert_equal "abc", message
  end

  def test_all_spaces
    braille = "......\n......\n......\n"
    night = NightReader.new
    message = night.decode_to_text(braille)
    assert_equal "   ", message
  end

  def test_punctuation
    braille = "......\n..0000\n000..0\n"
    night = NightReader.new
    message = night.decode_to_text(braille)
    assert_equal "!?.", message
  end

  def test_character_assembly
    braille = ['0.0.', '...0', '..00']
    night = NightReader.new
    letter = night.assemble_char(braille, 0)
    assert_equal ['0.', '..', '..'], letter
  end

  def test_shift_capitalization
    braille = "..0.0.\n..00.0\n.0....\n"
    night = NightReader.new
    message = night.decode_to_text(braille)
    assert_equal "He", message
  end

  def test_encoding_numbers
    skip
    text = '783'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "0.0.00\n..0...\n......\n", message
  end
end

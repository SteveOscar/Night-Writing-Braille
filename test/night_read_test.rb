require 'pry'
require 'minitest'
require 'minitest/autorun'
require './lib/night_read'

class NightReaderTest < Minitest::Test
  def test_decoding_letters
    braille = "0.0.00\n..0...\n......\n"
    night = NightReader.new
    message = night.decode_to_text(braille)
    assert_equal "abc", message
  end

  def test_ends_with_capital
    braille = "0...00\n.....0\n...000\n"
    night = NightReader.new
    message = night.decode_to_text(braille)
    assert_equal "aY", message
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

  def test_shift_switch
    braille = "..0.0.\n..00.0\n.0....\n"
    night = NightReader.new
    message = night.decode_to_text(braille)
    assert_equal "He", message
  end

  def test_number_switch
    braille = ".0000.00\n.00000..\n00......\n"
    night = NightReader.new
    message = night.decode_to_text(braille)
    assert_equal "783", message
  end
end

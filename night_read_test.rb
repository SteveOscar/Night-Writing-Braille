require 'pry'
require 'minitest'
require 'minitest/autorun'
require './night_read'

class NightReaderTest < Minitest::Test
  def test_decoding_letters
    text = "0.0.00\n..0...\n......\n"
    night = NightReader.new
    message = night.decode_to_text(text)
    assert_equal "abc", message
  end

  def test_all_spaces
    text = "......\n......\n......\n"
    night = NightReader.new
    message = night.decode_to_text(text)
    assert_equal "   ", message
  end

  def test_punctuation
    text = "......\n..0000\n000..0\n"
    night = NightReader.new
    message = night.decode_to_text(text)
    assert_equal "!?.", message
  end

  def test_encoding_numbers
    skip
    text = '783'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "0.0.00\n..0...\n......\n", message
  end
end

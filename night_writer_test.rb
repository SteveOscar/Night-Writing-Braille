require 'pry'
require 'minitest'
require 'minitest/autorun'
require './night_write'

class NightWriterTest < Minitest::Test
  def test_encoding_letters
    text = 'abc'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "0.0.00\n..0...\n......\n", message
  end

  def test_punctuation
    text = '!?.'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "......\n..0000\n000..0\n", message
  end

  def test_all_spaces
    text = '   '
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "......\n......\n......\n", message
  end

  def test_shift_capitalization
    text = 'Aa'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "..0.0.\n......\n.0....\n", message
  end
  #
  def test_single_number
    text = '8'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal ".00.\n.000\n00..\n", message
  end

  def test_multiple_numbers
    text = '82'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal ".00.0.\n.0000.\n00....\n", message
  end
end

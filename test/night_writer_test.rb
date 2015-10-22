require 'pry'
require 'minitest'
require 'minitest/autorun'
require './lib/night_write'

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

  def test_shift_switch
    text = 'Aa'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "..0.0.\n......\n.0....\n", message
  end

  def test_numbers_switch
    text = '82'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal ".00.0...\n.0000...\n00......\n", message
  end

  def test_capital_with_number
    text = 'A8'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "..0..00...\n.....000..\n.0..00....\n", message
  end
end

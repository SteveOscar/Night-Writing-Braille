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

  def test_encoding_numbers
    skip
    text = '783'
    night = NightWriter.new
    message = night.encode_to_braille(text)
    assert_equal "0.0.00\n..0...\n......\n", message
  end
end

require 'test/unit'
require File.dirname(__FILE__) + '/../lib/elfproef'

class ElfproefTest < Test::Unit::TestCase
  include Elfproef

  # Accounts that are not 9 digits should return false.
  def test_account_format
    assert_equal false, elfproef(123456)
    assert_equal false, elfproef(1234567890)
    assert_equal false, elfproef('12345678a')
  end

  # Invalid accounts should return a value greater than 0.
  def test_invalid_account
    assert_equal 9, elfproef(999999999)
    assert_equal 9, elfproef('99.99.99.999')
    assert_equal 9, elfproef('99 99 99 999')
  end

  # A valid account will return 0.
  def test_valid_account
    assert_equal 0, elfproef(123456789)
    assert_equal 0, elfproef('12.34.56.789')
    assert_equal 0, elfproef('12 34 56 789')
    assert_equal 0, elfproef(1234567)
    assert_equal 0, elfproef('1234567')
  end
end

require 'minitest'
require 'minitest/autorun'
require 'minitest/emoji'
require './lib/person'

class PersonTest < Minitest::Test

  def test_it_exists
    person = Person.new("Minerva", 100)

    assert_instance_of Person, person
  end

  def test_it_has_name_and_galleons
    person = Person.new("Minerva", 100)

    assert_equal "Minerva", person.name
    assert_equal 100, person.galleons
  end

  def test_it_can_have_different_name_and_galleon_amount
    person = Person.new("Bellatrix", 144)

    assert_equal "Bellatrix", person.name
    assert_equal 144, person.galleons
  end
end

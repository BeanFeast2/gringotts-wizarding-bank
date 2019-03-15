require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/bank'
require './lib/person'
require 'pry'

class BankTest < Minitest::Test

  def test_it_exists
    chase = Bank.new('JP Morgan Chase')

    assert_instance_of Bank, chase
  end

  def test_it_has_name
    chase = Bank.new('JP Morgan Chase')

    assert_equal 'JP Morgan Chase', chase.name
  end

  def test_it_can_have_different_name
    wells_fargo = Bank.new('Wells Fargo')

    assert_equal 'Wells Fargo', wells_fargo.name
  end

  def test_it_can_open_account_with_person
    person = Person.new("Bellatrix", 144)
    wells_fargo = Bank.new('Wells Fargo')
    wells_fargo.open_account(person)

    assert_equal "Bellatrix", wells_fargo.account_name(person)
  end

  def test_it_opens_account_with_no_money
    person = Person.new("Bellatrix", 144)
    wells_fargo = Bank.new('Wells Fargo')
    wells_fargo.open_account(person)

    assert_equal 0, wells_fargo.account_total(person)
  end

  def test_it_can_deposit_money
    person = Person.new("Bellatrix", 100)
    wells_fargo = Bank.new('Wells Fargo')
    wells_fargo.open_account(person)
    wells_fargo.deposit(person, 100)

    assert_equal 100, wells_fargo.account_total(person)
    assert_equal 0, person.galleons
  end

  def test_it_can_have_multiple_accounts
    person1 = Person.new("Bellatrix", 100)
    person2 = Person.new("Minerva", 130)
    wells_fargo = Bank.new('Wells Fargo')
    wells_fargo.open_account(person1)
    wells_fargo.open_account(person2)

    assert_equal 0, wells_fargo.account_total(person1)
    assert_equal "Bellatrix", wells_fargo.account_name(person1)
    assert_equal 0, wells_fargo.account_total(person2)
    assert_equal "Minerva", wells_fargo.account_name(person2)
  end

  def test_it_cant_deposit_more_than_person_has
    person = Person.new('Bellatrix', 50)
    wells_fargo = Bank.new('Wells Fargo')
    wells_fargo.open_account(person)

    wells_fargo.deposit(person, 100)

    assert_equal 0, wells_fargo.account_total(person)
  end

  def test_it_can_withdrawal_money
    person = Person.new('Bellatrix', 100)
    wells_fargo = Bank.new('Wells Fargo')
    wells_fargo.open_account(person)
    wells_fargo.deposit(person, 80)

    assert_equal 80, wells_fargo.account_total(person)

    wells_fargo.withdrawal(person, 40)

    assert_equal 40, wells_fargo.account_total(person)
    assert_equal 60, person.galleons
  end

  def test_it_cant_withdrawal_more_than_account_has
    person = Person.new('Bellatrix', 100)
    wells_fargo = Bank.new('Wells Fargo')
    wells_fargo.open_account(person)
    wells_fargo.deposit(person, 80)

    assert_equal 80, wells_fargo.account_total(person)

    wells_fargo.withdrawal(person, 100)

    assert_equal 80, wells_fargo.account_total(person)
    assert_equal 20, person.galleons
  end

  def test_it_can_transfer_person_to_different_account
    person = Person.new('Bellatrix', 100)
    wells_fargo = Bank.new('Wells Fargo')
    chase = Bank.new('JP Morgan Chase')
    wells_fargo.open_account(person)
    chase.open_account(person)
    wells_fargo.deposit(person, 50)

    assert_equal 0, chase.account_total(person)

    wells_fargo.transfer(person, chase, 50)

    assert_equal 50, chase.account_total(person)
    assert_equal 0, wells_fargo.account_total(person)
  end

  def test_it_cant_transfer_more_money_than_account_total
    person = Person.new('Bellatrix', 100)
    wells_fargo = Bank.new('Wells Fargo')
    chase = Bank.new('JP Morgan Chase')
    wells_fargo.open_account(person)
    chase.open_account(person)
    wells_fargo.deposit(person, 50)

    wells_fargo.transfer(person, chase, 200)

    assert_equal 0, chase.account_total(person)
  end

  def test_it_cant_transfer_to_account_thats_not_opened
    person = Person.new('Bellatrix', 100)
    wells_fargo = Bank.new('Wells Fargo')
    chase = Bank.new('JP Morgan Chase')
    wells_fargo.open_account(person)
    wells_fargo.deposit(person, 50)

    actual = wells_fargo.transfer(person, chase, 50)
    expected = "Bellatrix does not have an account with JP Morgan Chase"

    assert_equal expected, actual
  end

  def test_it_can_show_banks_total_amount
    person1 = Person.new("Bellatrix", 200)
    person2 = Person.new("Minerva", 130)
    chase = Bank.new('JP Morgan Chase')
    chase.open_account(person1)
    chase.open_account(person2)
    chase.deposit(person1, 200)
    chase.deposit(person2, 130)

    assert_equal 330, chase.total_galleons_in_bank
  end
end

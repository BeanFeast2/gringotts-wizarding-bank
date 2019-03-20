class Bank
  attr_reader :name
  def initialize(name)
    @name = name
    @accounts = []
  end

  def open_account(person)
    @accounts.push({
      :account_holder => person.name,
      :account_total => 0
    })
  end

  def account_name(person)
    @accounts.each do |account|
      if account[:account_holder] == person.name
        return account[:account_holder]
      end
    end
  end

  def account_total(person)
    @accounts.each do |account|
      if account[:account_holder] == person.name
        return account[:account_total]
      end
    end
  end

  def deposit(person, amount)
    @accounts.each do |account|
      if account[:account_holder] == person.name
        if person.galleons >= amount
          account[:account_total] += amount
          person.galleons -= amount
        end
      end
    end
  end

  def withdrawal(person, amount)
    @accounts.each do |account|
      if account[:account_holder] == person.name
        if account[:account_total] >= amount
          account[:account_total] -= amount
          person.galleons += amount
        end
      end
    end
  end

  def transfer(person, new_account, amount)
    @accounts.each do |account|
      if account[:account_holder] == person.name
        if account[:account_total] >= amount
          account[:account_total] -= amount
          if !new_account.account_name(person).empty?
            new_account.deposit(person, amount)
          else
            return "#{account[:account_holder]} does not have an account with #{new_account.name}"
          end
        end
      end
    end
  end

  def total_galleons_in_bank
    sum = 0
    @accounts.each do |account|
      sum += account[:account_total]
    end
    sum
  end
end

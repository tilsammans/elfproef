# Elfproef.
module Elfproef
  # Checks if an ActiveRecord property is a valid Dutch bank account number.
  def validates_elfproef_of(*attrs)
    configuration = { :message => ActiveRecord::Errors.default_error_messages[:invalid], :on => :save, :with => nil }
    configuration.update(attrs.pop) if attrs.last.is_a?(Hash)

    validates_each(attrs, configuration) do |record, attr_name, value|
      record.errors.add(attr_name, configuration[:message]) unless elfproef(value) == 0
    end
  end

  private
  # Calculates the elfproef of a Dutch bank account number.
  # Return value should be 0 (proof succeeded). Any other value means faillure.
  # Postbank accounts (7 digits) cannot be validated using the elfproef and will always return 0 (success).
  # http://nl.wikipedia.org/wiki/Elfproef
  def elfproef(account)
    account, sum = account.to_s, 0
    account.gsub!(/\D/, '') 								# strip out any non-digit character.
    return 0 if account.length == 7						# always pass postbank accounts (7 digits)
    return false unless account =~ /^\d{9}$/			# account should be exactly 9 digits
    (1..9).each do |c|
      sum += account[-c].chr.to_i * c
    end
    sum % 11
  end
end

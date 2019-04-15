require_relative "./journal_entry"
require_relative "./pricing_policies/default"
require_relative "./pricing_policies/winter"

GOODS = {
  "CU" => "Огурцы",
  "TO" => "Помидоры",
  "CO" => "Кукуруза"
}

class Storage
  attr_reader :journal_entries

  def initialize(pricing_policy = nil)
    @journal_entries = []
    @pricing_policy = pricing_policy
  end

  def accept(code, weight)
    price = accepting_price(code)
    total_price = price * weight
    @journal_entries << JournalEntry.new(code, weight)
    puts "#{GOODS[code]} в кол-ве #{weight} кг приняты по #{price} тенге за кг, на общую сумму #{total_price} тенге."
    stock
  end

  def accepting_price(code)
    @pricing_policy.get[code].each { |k, v| break(v) if k.cover?(weight_of(code)) }
  end

  def entries_of(code)
    @journal_entries.select { |journal_entry| journal_entry.code == code }
  end

  def weight_of(code)
    entries_of(code).map(&:weight).reduce(0, :+)
  end

  def stock
    puts "-----------------"
    puts "Текущие запасы:"
    puts "-----------------"
    GOODS.each do |k, v|
      printf "%-10s %6s\n", v, weight_of(k)
    end
  end
end

require_relative "./journal_entry"

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
    @journal_entries << JournalEntry.new(code, weight)
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

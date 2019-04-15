GOODS = {
  "CU" => "Огурцы",
  "TO" => "Помидоры",
  "CO" => "Кукуруза"
}

class Storage
  def initialize(pricing_policy = nil)
    @journal_entries = []
    @pricing_policy = pricing_policy
  end

  def accept
    raise NotImplementedError
  end

  def stock
    puts "-----------------"
    puts "Текущие запасы:"
    puts "-----------------"
    GOODS.each do |k, v|
      printf "%-10s %6s\n", v, 0
    end
  end
end

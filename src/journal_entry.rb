class JournalEntry
  attr_reader :code, :weight

  def initialize(code, weight)
    @code = code
    @weight = weight
  end
end
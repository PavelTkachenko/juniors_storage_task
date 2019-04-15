module PricingPolicies
  class Default
    def get
      {
        "CU" => {0..999 => 100, 1_000..Float::INFINITY => 80 },
        "TO" => {0..1_999 => 250, 2_000..2_999 => 200, 3_000..Float::INFINITY => 150 },
        "CO" => { 0..Float::INFINITY => 40 }
      }
    end
  end
end
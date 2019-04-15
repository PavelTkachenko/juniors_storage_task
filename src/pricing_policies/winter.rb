module PricingPolicies
  class Winter
    def get
      {
        "CU" => {0..999 => 150, 1_000..Float::INFINITY => 100 },
        "TO" => {0..1_999 => 280, 2_000..2_999 => 230, 3_000..Float::INFINITY => 150 },
        "CO" => { 0..99 => 80, 100..Float::INFINITY => 40 }
      }
    end
  end
end
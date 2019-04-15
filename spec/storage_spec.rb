require "rspec"
require_relative "../src/storage"

describe Storage do
  subject { Storage.new(PricingPolicies::Default.new) }

  it "prints current stock" do
    expect { subject.stock }.to output(
      <<-EOT.gsub(/^\s+/, '')
        -----------------
        Текущие запасы:
        -----------------
        Огурцы          0
        Помидоры        0
        Кукуруза        0
      EOT
    ).to_stdout
  end

  describe "#accept" do
    it "adds jounral entry with code and weight" do
      subject.accept("CU", 50)
      subject.accept("CU", 50)
      subject.accept("TO", 100)
      expect { subject.stock }.to output(
        <<-EOT.gsub(/^\s+/, '')
          -----------------
          Текущие запасы:
          -----------------
          Огурцы        100
          Помидоры      100
          Кукуруза        0
        EOT
      ).to_stdout
    end
  end

  describe "DEFAULT PRICING POLICY" do
    subject { Storage.new(PricingPolicies::Default.new) }

    describe "#accept" do
      it "adds jounral entry with code and weight" do
        expect { subject.accept("CU", 1100) }.to output(
          <<-EOT.gsub(/^\s+/, '')
            Огурцы в кол-ве 1100 кг приняты по 100 тенге за кг, на общую сумму 110000 тенге.
            -----------------
            Текущие запасы:
            -----------------
            Огурцы       1100
            Помидоры        0
            Кукуруза        0
          EOT
        ).to_stdout

        expect { subject.accept("CU", 500) }.to output(
          <<-EOT.gsub(/^\s+/, '')
            Огурцы в кол-ве 500 кг приняты по 80 тенге за кг, на общую сумму 40000 тенге.
            -----------------
            Текущие запасы:
            -----------------
            Огурцы       1600
            Помидоры        0
            Кукуруза        0
          EOT
        ).to_stdout
      end
    end
  end

  describe "WINTER PRICING POLICY" do
    subject { Storage.new(PricingPolicies::Winter.new) }
    
    describe "#accept" do
      it "adds jounral entry with code and weight" do
        expect { subject.accept("CU", 1100) }.to output(
          <<-EOT.gsub(/^\s+/, '')
            Огурцы в кол-ве 1100 кг приняты по 150 тенге за кг, на общую сумму 165000 тенге.
            -----------------
            Текущие запасы:
            -----------------
            Огурцы       1100
            Помидоры        0
            Кукуруза        0
          EOT
        ).to_stdout

        expect { subject.accept("CU", 500) }.to output(
          <<-EOT.gsub(/^\s+/, '')
            Огурцы в кол-ве 500 кг приняты по 100 тенге за кг, на общую сумму 50000 тенге.
            -----------------
            Текущие запасы:
            -----------------
            Огурцы       1600
            Помидоры        0
            Кукуруза        0
          EOT
        ).to_stdout
      end
    end
  end
end

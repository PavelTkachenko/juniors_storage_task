require "rspec"
require_relative "../src/storage"

describe Storage do
  subject { Storage.new }

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
end

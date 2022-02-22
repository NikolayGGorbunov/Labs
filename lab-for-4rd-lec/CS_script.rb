def cs_script(word)
  word.end_with?('CS') ? 2**word.length : word.reverse
end

print "Введите слово.\n"
puts cs_script(gets.chomp!)

#-------------------TESTS-------------------
require 'rspec'

RSpec.describe 'cs_script method' do
  it "return 2^(word length) (== 8) if word end with 'CS'" do
    expect(cs_script('8CS')).to eq(8)
  end
  it "return reversed word (== esrever) if word not end with 'CS'" do
    expect(cs_script('reverse')).to eq('esrever')
  end
end

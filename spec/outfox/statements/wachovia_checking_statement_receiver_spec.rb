require File.join(File.dirname(__FILE__), *%w[.. .. spec_helper])

describe Outfox::Statements::WachoviaCheckingStatement do
  before(:all) do
    @config = YAML.load_file(File.join(CONFIG_PATH, 'account_info.yml'))
    @parser = Outfox::Parser.new(@config['bank_name'], @config['account_type'])
    @statement = @parser.receiver
    file_path = [@config['bank_name'], @config['account_type'], 'statement.pdf'].join('_')
    fixture_path = File.join(FIXTURES_PATH, file_path)
    @parser.parse(StringIO.new, fixture_path)
  end
  
  it "should have correct start date" do
    @statement.start_date.should == DateTime.parse(@config['start_date'])
  end
  
  it "should have correct end date" do
    @statement.end_date.should == DateTime.parse(@config['end_date'])
  end
  
  it "should have transactions" do
    @statement.transactions.size.should == 5
    puts Outfox::OfxGenerator.new(@statement).ofx
  end
  
  it "should have deposits" do
    pending
  end
  
  describe "account info" do
    it "should have account number" do
      @statement.account_number.should == @config['account_number']
    end
    
    it "should have bank routing number" do
      @statement.bank_routing_number.should be_an_instance_of(String)
    end
    
    it "should have account type" do
      @statement.account_type.should be_an_instance_of(String)
    end
  end
  
  describe "#start_of_transaction?" do
    before(:all) do
      @statement = Outfox::Statements::WachoviaCheckingStatement.new
    end
    
    it "should start transaction for month/" do
      (1..12).each do |i|
        @statement.start_of_transaction?(["#{i}/"]).should be_true
      end
    end
    
    it "should not start transaction for non-numeric text" do
      @statement.start_of_transaction?(['foo/']).should be_false
    end
    
    it "should not start transaction for string without slash" do
      @statement.start_of_transaction?(['foo']).should be_false
    end
    
    it "should not start transaction for non-month number" do
      @statement.start_of_transaction?(['13/']).should be_false
    end
    
    it "should not start transaction for 0" do
      @statement.start_of_transaction?(['0/']).should be_false
    end
  end

end
require File.join(File.dirname(__FILE__), *%w[.. .. spec_helper])

describe Outfox::Receivers::WachoviaCheckingStatement do
  before(:all) do
    @config = YAML.load_file(File.join(CONFIG_PATH, 'account_info.yml'))
  end

  describe "account info" do
    before(:all) do
      @parser = Outfox::Parser.new(@config['bank_name'], @config['account_type'])
      @statement = @parser.receiver
      file_path = [@config['bank_name'], @config['account_type'], 'statement.pdf'].join('_')
      fixture_path = File.join(FIXTURES_PATH, file_path)
      @parser.parse(StringIO.new, fixture_path)
    end

    it "should have account number" do
      @statement.account_number.should == @config['account_number']
    end
    
    it "should have bank routing number" do
      @statement.bank_routing_number.should be_an_instance_of(String)
    end
    
    it "should have account type" do
      @statement.account_type.should be_an_instance_of(String)
    end
    
    it "should have a start date" do
      @statement.start_date.should == DateTime.parse(@config['start_date'])
    end
    
    it "should have an end date" do
      @statement.end_date.should == DateTime.parse(@config['end_date'])
    end
    
    it "should have transactions"
  end
  
  describe "#start_of_transaction?" do
    before(:all) do
      @statement = Outfox::Receivers::WachoviaCheckingStatement.new
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
require File.join(File.dirname(__FILE__), *%w[.. .. spec_helper])

describe Outfox::Receivers::WachoviaCheckingStatement do
  before(:all) do
    @config = YAML.load_file(File.join(CONFIG_PATH, 'account_info.yml'))
  end

  describe "config" do
    it "should have a bank name" do
      @config['bank_name'].should_not be_nil
    end

    it "should have an account type" do
      @config['account_type'].should_not be_nil
    end

    it "should have an account number" do
      @config['account_number'].should_not be_nil
    end
  end

  describe "account info" do
    before(:each) do
      @parser = Outfox::Parser.new(@config['bank_name'], @config['account_type'])
      @receiver = @parser.receiver
      @messenger = StringIO.new
      file_path = [@config['bank_name'], @config['account_type'], 'statement.pdf'].join('_')
      fixture_path = File.join(FIXTURES_PATH, file_path)
      @parser.parse(@messenger, fixture_path)
    end

    it "should have account number" do
      @receiver.account_number.should == @config['account_number']
    end
  end

end
require File.join(File.dirname(__FILE__), *%w[.. spec_helper])

describe Outfox::Parser do
  before(:all) do
    @config = YAML.load_file(File.join(CONFIG_PATH, 'account_info.yml'))
  end

  before(:each) do
    @messenger = StringIO.new
    @parser = Outfox::Parser.new(@config['bank_name'], @config['account_type'])
  end

  it "should have correct receiver" do
    @parser.receiver.class.should == Outfox::Statements::WachoviaCheckingStatement
  end

  describe "parsing messages" do

    it "should write a message when beginning to parse a pdf file" do
      path_to_valid_pdf = File.join(FIXTURES_PATH, 'minimal_valid_1.pdf')
      @messenger.should_receive(:write).with(Outfox::Messages.starting_to_parse(path_to_valid_pdf))
      @parser.parse(@messenger, path_to_valid_pdf)
    end

    it "should write an error message for unparseable file" do
      @messenger.should_receive(:write).with(Outfox::ErrorMessages::UNPARSEABLE)
      path_to_text_file = File.join(FIXTURES_PATH, 'test.txt')
      @parser.parse(@messenger, path_to_text_file)
    end

    it "should write an error message for non-existent file" do
      @messenger.should_receive(:write).with(/No such file or directory/)
      path_to_nonexistent_file = File.join(FIXTURES_PATH, "nonexistent.pdf")
      @parser.parse(@messenger, path_to_nonexistent_file)
    end

  end

end
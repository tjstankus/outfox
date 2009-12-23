When /^I run outfox with (options|arguments) ([^\"]*)$/ do |ignore, args|
  %x"#{OUTFOX_COMMAND} #{args} #{TMP_OUTPUT_REDIRECT}"
end

Then /^I should see the help message$/ do
  stdout = File.read(TMP_OUTPUT_PATH)
  stdout.should match(/Outfox/)
end

Then /^I should see instructions for viewing the help message$/ do
  stdout = File.read(TMP_OUTPUT_PATH)
  stdout.should match(/outfox --help/)
end

When /^I run outfox with "([^\"]*)"$/ do |filepath|
  %x"#{OUTFOX_COMMAND} #{filepath}"
end

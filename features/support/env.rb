$LOAD_PATH << File.join(File.dirname(__FILE__), *%w[.. .. lib])
require 'outfox'
require 'fileutils'
require 'spec/expectations'
require 'spec/mocks'

APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), *%w[.. ..]))
OUTFOX_COMMAND = File.join(APP_ROOT, *%w[bin outfox])
TMP_OUTPUT_DIR = File.join(APP_ROOT, 'tmp')
TMP_OUTPUT_PATH = File.join(TMP_OUTPUT_DIR, 'output.log')
TMP_OUTPUT_REDIRECT = '> ' + TMP_OUTPUT_PATH + ' 2>&1'
FIXTURE_PATH = File.join(APP_ROOT, *%w[spec fixtures])
CONFIG_PATH = File.join(APP_ROOT, *%w[spec config])

Before('@tmpoutput') do
  FileUtils.mkdir_p(TMP_OUTPUT_DIR)
  FileUtils.touch(TMP_OUTPUT_PATH)
end

After('@tmpoutput') do
  FileUtils.remove_file(TMP_OUTPUT_PATH)
  FileUtils.remove_dir(TMP_OUTPUT_DIR)
end

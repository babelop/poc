require 'minitest/spec'
require 'minitest/autorun'

describe "bsd tar archive" do

  describe "when extracted with bin/tar" do
    it "will not produce extra files" do
      %x{ls build/extract_bintar/bsdarchive}.chomp.must_equal "helloworld.rb"
    end
  end

  describe "when extracted with minittar" do
    it "will not produce extra files" do
      %x{ls build/extract_minitar/bsdarchive}.chomp.must_equal "helloworld.rb"
    end
  end

end

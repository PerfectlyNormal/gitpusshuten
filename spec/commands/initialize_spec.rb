# encoding: utf-8
require 'spec_helper'

describe GitPusshuTen::Commands::Initialize do

  command_setup!('Initialize', %w[initialize])
  
  before do
    command.stubs(:copy_templates!)
    command.stubs(:working_directory).returns(Dir.pwd)
  end
  
  it "should not perform deploy hooks" do
    command.perform_hooks?.should be_false
  end

  context "when allowing Git Pusshu Ten to initialize" do
    it do
      command.expects(:may_initialize?).returns(true)
      GitPusshuTen::Log.expects(:message).with("Git Pusshu Ten (プッシュ点) initialized in: #{Dir.pwd}!")
      command.perform!
    end
  end

  context "when disallowing Git Pusshu Ten to initialize" do
    it do
      command.expects(:may_initialize?).returns(false)
      GitPusshuTen::Log.expects(:message).with("If you wish to initialize it elsewhere, " +
      "please move into that directory and run gitpusshuten initialize again.")
      command.perform!
    end
  end
  
end
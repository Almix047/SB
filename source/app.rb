# frozen_string_literal: true

require_relative 'record_to_file.rb'
require_relative 'input_list_fetcher.rb'

INPUT = InputListFetcher.read_from_file

HOST = 'https://socialblade.com/instagram/user/'

options = Selenium::WebDriver::Firefox::Options.new
options.profile = 'my-profile'

DRIVER = Selenium::WebDriver.for :firefox, options: options

RecordToFile.save_as_csv_file

DRIVER.quit

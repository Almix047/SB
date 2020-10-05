# frozen_string_literal: true

require_relative 'record_to_file.rb'
require_relative 'input_list_fetcher.rb'

INPUT = InputListFetcher.read_from_file

# DRIVER = Selenium::WebDriver.for :firefox

RecordToFile.save_as_csv_file

# DRIVER.quit

# frozen_string_literal: true

require 'selenium-webdriver'
require 'nokogiri'

class PageParser
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def fetch_page
    @fetch_page ||= parse_page(link)
  end

  private

  def parse_page(link)
    DRIVER.navigate.to link
    timeout
    Nokogiri::HTML(DRIVER.page_source)
  end

  def timeout
    seconds = rand(3..9)
    seconds.times do |curr_sec|
      puts seconds - curr_sec
      sleep(1)
    end
  end
end

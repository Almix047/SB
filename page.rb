# frozen_string_literal: true

require_relative 'page_parser.rb'
require_relative 'xpath_const.rb'

class Page
  attr_reader :parser, :date

  def initialize(link)
    @parser = PageParser.new(link)
    @date = table_date
  end

  def valid_page?
    parser.fetch_page.xpath(VALID_XPATH).empty?
  end

  def resource_page?
    parser.fetch_page.xpath(VALID_RESOURCE_XPATH).empty?
  end

  def login
    parser.fetch_page.xpath(LOGIN_XPATH).text.strip
  end

  def followers
    parser.fetch_page.xpath(FOLLOWERS_XPATH).text.tr(',', '')
  end

  def er
    parser.fetch_page.xpath(ER_XPATH).text.strip
  end

  def table_daily
    date_xpath = "//div[contains(text(), '#{date}')]/../..//span"
    parser.fetch_page.xpath(date_xpath)
  end

  def table_followers_avg
    parser.fetch_page.xpath(TABLE_AVG_FOLLOWERS_XPATH)[0].text.tr(',', '')
  end

  def table_media_avg
    parser.fetch_page.xpath(TABLE_AVG_FOLLOWERS_XPATH)[2].text.tr(',', '')
  end

  private

  def table_date
    current_time = Time.now.localtime
    yesterday = current_time - 86_400
    yesterday.strftime('%Y-%m-%d')
  end
end

# frozen_string_literal: true

require_relative 'page_parser.rb'

DAY = 86_400

LOGIN_XPATH = '//div[@id="YouTubeUserTopInfoBlockTop"]//h2/text()'

TOP_INFO_BLOCK = '//div[@id="YouTubeUserTopInfoBlockTop"]//div[@class="YouTubeUserTopInfo"]'
FOLLOWERS_XPATH = TOP_INFO_BLOCK + '/span[text()="Followers"]/../span[2]'
ER_XPATH = TOP_INFO_BLOCK + '/span[text()="Engagement Rate"]/../span[3]'

TABLE_AVG_FOLLOWERS_XPATH = '//div[contains(text(), "Daily Averages")]/..//span'

VALID_XPATH = '//div[contains(text(), "The API is unable to find this username")]'
VALID_RESOURCE_XPATH = '//span[@data-translate="checking_browser"]'

class Page
  attr_reader :parser, :date

  def initialize(link)
    @parser = PageParser.new(link)
    @date = Time.now.localtime
  end

  def valid_page?
    parser.fetch_page.xpath(VALID_XPATH).empty?
  end

  def resource_page?
    parser.fetch_page.xpath(VALID_RESOURCE_XPATH).empty?
  end

  def login
    parser.link[%r|https:\/{2}\w+\.com\/\w+\/user\/(\w+)|, 1]
  end

  def followers
    parser.fetch_page.xpath(FOLLOWERS_XPATH).text.tr(',', '')
  end

  def er
    parser.fetch_page.xpath(ER_XPATH).text.strip
  end

  def table_today_followers
    today = date.strftime('%Y-%m-%d')
    date_xpath = "//div[contains(text(), '#{today}')]/../..//span"
    flw = parser.fetch_page.xpath(date_xpath)
    if flw.any?
      flw[0].text.tr(',', '')
    else
      'nevalid'
    end
  end

  def table_daily
    yesterday = (date - DAY).strftime('%Y-%m-%d')
    date_xpath = "//div[contains(text(), '#{yesterday}')]/../..//span"
    parser.fetch_page.xpath(date_xpath)
  end

  def table_followers_avg
    parser.fetch_page.xpath(TABLE_AVG_FOLLOWERS_XPATH)[0].text.tr(',', '')
  end

  def table_media_avg
    parser.fetch_page.xpath(TABLE_AVG_FOLLOWERS_XPATH)[2].text.tr(',', '')
  end
end

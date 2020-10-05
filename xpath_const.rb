# frozen_string_literal: true

LOGIN_XPATH = '//div[@id="YouTubeUserTopInfoBlockTop"]//h2/text()'

TOP_INFO_BLOCK = '//div[@id="YouTubeUserTopInfoBlockTop"]//div[@class="YouTubeUserTopInfo"]'
FOLLOWERS_XPATH = TOP_INFO_BLOCK + '/span[text()="Followers"]/../span[2]'
ER_XPATH = TOP_INFO_BLOCK + '/span[text()="Engagement Rate"]/../span[3]'

TABLE_AVG_FOLLOWERS_XPATH = '//div[contains(text(), "Daily Averages")]/..//span'

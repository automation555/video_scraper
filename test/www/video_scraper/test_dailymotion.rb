# -*- mode:ruby; coding:utf-8 -*-

require File.dirname(__FILE__) + '/../../test_helper'

class TestDailymotion < Test::Unit::TestCase
  def test_scrape
    vs = WWW::VideoScraper::Dailymotion.scrape('http://www.dailymotion.com/mokelov/japan/video/x12gr3_music', default_opt)
    assert_equal 'http://www.dailymotion.com/mokelov/japan/video/x12gr3_music', vs.page_url
    assert_match %r|http://www\.dailymotion\.com/get/\d{2}/\d+x\d+/flv/\d+\.flv\?key=[[:alnum:]]+|, vs.video_url
    assert_match %r|http://\w+\.static\.dailymotion\.com/dyn/preview/\d+x\d+/\d+\.jpg\?\d{14}|, vs.thumb_url
    assert_match %r|^<div><object\s.*</div>$|, vs.embed_tag
    assert_equal '遭難　東京事変', vs.title
  end
end

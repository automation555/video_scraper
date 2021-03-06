# -*- mode:ruby; coding:utf-8 -*-

require File.dirname(__FILE__) + '/../../test_helper'

class TestYouTube < Test::Unit::TestCase
  def setup
    config = Pit.get('youtube.com', :require => {
                       'username' => 'your email in youtube.com',
                       'password' => 'your password in youtube.com'
                     })
    default_opt.merge!(:you_tube_username => config['username'],
                       :you_tube_password => config['password'])
  end

  def test_scrape
    vs = WWW::VideoScraper::YouTube.scrape('http://jp.youtube.com/watch?v=Ym20IwIUbuU', default_opt)
    assert_equal 'http://jp.youtube.com/watch?v=Ym20IwIUbuU', vs.page_url
    assert_match %r|http://jp\.youtube\.com/get_video\?video_id=Ym20IwIUbuU&t=[-_[:alnum:]]{32}|, vs.video_url
    assert_match %r|http://\w\.ytimg\.com/vi/Ym20IwIUbuU/default\.jpg|, vs.thumb_url
    assert_match %r|^<object\s+.*</object>$|, vs.embed_tag
    assert_equal 'とらドラ！Toradora ep15 2-3', vs.title
  end

  def test_scrape_alt_url
    vs = WWW::VideoScraper::YouTube.scrape('http://jp.youtube.com/watch?v=ATHC8qDkoO0', default_opt)
    assert_equal 'http://jp.youtube.com/watch?v=ATHC8qDkoO0', vs.page_url
    assert_match %r|http://jp\.youtube\.com/get_video\?video_id=ATHC8qDkoO0&t=[-_[:alnum:]]{32}|, vs.video_url
    assert_match %r|http://\w\.ytimg\.com/vi/ATHC8qDkoO0/default\.jpg|, vs.thumb_url
    assert_match %r|^<object\s+.*</object>$|, vs.embed_tag
    assert_equal "019' Sexii_Shower 藤澤まお_洗白白", vs.title
  end
end

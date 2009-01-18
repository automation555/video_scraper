# -*- mode:ruby; coding:utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '/base')

module WWW
  module VideoScraper
    class Veoh < Base
      url_regex %r!\Ahttp://www\.veoh\.com/videos/([[:alnum:]]+)!

      private
      def scrape
        @id = url_regex_match[1]
        request_url = "http://www.veoh.com/rest/video/#{@id}/details"
        xml = http_get(request_url)
        @video_url = xml.match(/fullPreviewHashPath="([^"]+)"/).to_a[1]
        @title = xml.match(/title="([^"]+)"/).to_a[1]
        @thumb_url = xml.match(/fullMedResImagePath="([^"]+)"/).to_a[1]
        html = http_get(@page_url)
        embed_tag = html.match(/\sid="embed"\s[^>]*value="([^"]+)"/).to_a[1]
        @embed_tag = CGI.unescapeHTML embed_tag
      end
    end
  end
end


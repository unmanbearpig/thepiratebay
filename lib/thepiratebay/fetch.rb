require 'nokogiri'
require 'open-uri'
require 'uri'

module ThePirateBay
  class Fetch
    attr_reader :torrents
    alias_method :results, :torrents

    def initialize(url)
      doc = Nokogiri::HTML(open(url))
      torrents = []

      doc.css('#searchResult tr').each do |row|
        title = row.search('.detLink').text
        next if title == ''

        seeders     = row.search('td')[2].text.to_i
        leechers    = row.search('td')[3].text.to_i
        magnet_link = row.search('td a')[3]['href']
        category    = row.search('td a')[0].text
        url         = row.search('.detLink').attribute('href').to_s
        torrent_id  = url.split('/')[2]

        torrent = {:title       => title,
                   :seeders     => seeders,
                   :leechers    => leechers,
                   :magnet_link => magnet_link,
                   :category    => category,
                   :torrent_id  => torrent_id,
                   :url         => url}

        torrents.push(torrent)
      end

      @torrents = torrents
    end
  end
end

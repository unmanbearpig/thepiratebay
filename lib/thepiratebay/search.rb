require 'uri'

module ThePirateBay
  class Search
    attr_reader :torrents
    alias_method :results, :torrents

    def initialize(query, options = {})
      page = options[:page] || 0
      sort_by = options[:sort_by] || 99
      category = options[:category] || 0

      query = URI.escape(query)
      fetch = Fetch.new 'http://thepiratebay.org/search/' + query + '/' + page.to_s + '/' + sort_by.to_s + '/' + category.to_s + ''
      @torrents = fetch.torrents
    end
  end
end

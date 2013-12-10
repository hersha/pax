require 'mechanize'

module PAX
  class Event
    def initialize(location)
      @site = Mechanize.new.get("http://#{location}.paxsite.com/")
    end

    def site
      @site.body
    end

    def registration_open?
      @site.search(".registration").to_html =~ /open/ ? true : false
    end
    
    def registration_closed?
      !registration_open?
    end

    def sold_out?
      @site.search(".soldOut").to_html =~ /Sold Out/ ? true : false
    end

    def available?
      !sold_out?
    end
  end
end

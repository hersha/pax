require_relative '../../../lib/pax/event'
require 'spec_helper'

module PAX
  describe Event do
    let(:pax_prime) { Event.new('prime') }
    let(:pax_east) { Event.new('east') }
    let(:html_header) { {content_type: 'text/html'} }
    it 'scrapes the PAX Prime website' do
      stub_request(:get, 'prime.paxsite.com').to_return(body: 'prime')
      pax_prime
      WebMock.should have_requested(:get, 'prime.paxsite.com')
    end
    it 'scrapes the PAX East website' do
      stub_request(:get, 'east.paxsite.com').to_return(body: 'east')
      pax_east
      WebMock.should have_requested(:get, 'east.paxsite.com')
    end
    describe '#registration_open?' do
      it 'returns true if PAX prime registration is open' do
        stub_request(:get, 'prime.paxsite.com').to_return(body: '<div class="registration">open</div>', headers: html_header)
        pax_prime.registration_open?.should == true
      end
      it 'returns false if PAX prime registration is closed' do
        stub_request(:get, 'prime.paxsite.com').to_return(body: '<div class="registration">closed</div>', headers: html_header)
        pax_prime.registration_open?.should == false
      end
    end
    describe '#sold_out?' do
      it 'returns true if PAX is sold out' do
        stub_request(:get, 'prime.paxsite.com').to_return(body: '<div class="soldOut">Sold Out</div>', headers: html_header)
        pax_prime.sold_out?.should == true
      end
      it 'returns false if PAX is not sold out' do
        stub_request(:get, 'prime.paxsite.com').to_return(body: '<div class="soldOut"></div>', headers: html_header)
        pax_prime.sold_out?.should == false
      end
    end
  end
end

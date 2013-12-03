require_relative '../lib/pax'
require 'spec_helper'

describe PAX do
  let(:pax_prime) { PAX.new("prime") }
  let(:pax_east) { PAX.new("east") }
  it "scrapes the PAX Prime website" do
    stub_request(:get, "prime.paxsite.com").to_return(body: "prime")
    pax_prime
    WebMock.should have_requested(:get, "prime.paxsite.com")
  end
  it "scrapes the PAX East website" do
    stub_request(:get, "east.paxsite.com").to_return(body: "east")
    pax_east
    WebMock.should have_requested(:get, 'east.paxsite.com')
  end
  describe '#registration_open?' do
    it "returns true if PAX prime registration is open" do
      stub_request(:get, "prime.paxsite.com").to_return(body: "<div class='registration'>open</div>", headers: {content_type: "text/html"})
      pax_prime.registration_open?.should == true
    end
    it "returns false if PAX prime registration is closed" do
      stub_request(:get, "prime.paxsite.com").to_return(body: "<div class='registration'>closed</div>", headers: {content_type: "text/html"})
      pax_prime.registration_open?.should == false
    end
  end
  describe '#sold_out?' do
    it "returns true if PAX is sold out" do
      stub_request(:get, "prime.paxsite.com").to_return(body: "<div class='soldOut'>Sold Out</div>", headers: {content_type: "text/html"})
      pax_prime.sold_out?.should == true
    end
    it "returns false if PAS is not sold out" do
      stub_request(:get, "prime.paxsite.com").to_return(body: "<div class='soldOut'></div>", headers: {content_type: "text/html"})
      pax_prime.sold_out?.should == false
    end
  end
end
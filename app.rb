require 'sinatra'
require 'builder'
require 'yahoofinance'
 
post '/' do
  builder do |xml|
    xml.instruct!
    xml.Response do 
      xml.Say("Hello hello hello from my Heroku app")
      xml.Gather(:action=>"/reply")  do
	xml.Say("Please input stock quote")
      end
    end
  end
end

post '/reply' do
  builder do |xml|
    xml.instruct!
    xml.Response do
      stock = params['Digits'] + '.HK'
      YahooFinance::get_standard_quotes(stock).each do |symbol, quote|
	xml.Say("#{quote.name} was last traded at #{quote.lastTrade}")
      end
    end
  end
end

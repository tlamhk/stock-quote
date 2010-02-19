require 'sinatra'
require 'builder'
require 'yahoofinance'
 
post '/' do
  builder do |xml|
    xml.instruct!
    xml.Response do 
      xml.Say("Hello hello hello from my stock quote app")
      xml.Gather(:action=>"/reply")  do
			xml.Say("Please input stock quote, followed by hash")
      end
    end
  end
end

post '/reply' do
  builder do |xml|
    xml.instruct!
    xml.Response do
      stock = params['Digits'].rjust(4,'0') + '.HK'
      YahooFinance::get_standard_quotes(stock).each do |symbol, quote|
		  xml.Say("#{quote.name} was last traded at #{quote.lastTrade} dollar")
		  xml.Gather(:action=>"/loop", :numDigits => 1) do		  
		  	 xml.Say("Press one to input again or two to end this call")
		  end
      end
    end
  end
end

post '/loop' do
	if params['Digits'] != '1'
		builder do |xml|
			xml.instruct!
			xml.Response do
				xml.Say("good bye")
			end
		end
	else
		redirect_to :action => "/"
	end
end	

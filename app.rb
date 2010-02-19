require 'sinatra'
require 'builder'
 
post '/' do
  builder do |xml|
    xml.instruct!
    xml.Response do 
      xml.Say("Hello hello hello from my Heroku app")
      xml.Gather(:action=>"/reply")  do
	xml.Say("Please press 1 or 2")
      end
    end
  end
end

post '/reply' do
  builder do |xml|
    xml.instruct!
    xml.Response do
      if params['Digits'] == '1'
        xml.Say("you pressed one")
      else
	xml.Say("you pressed two")
      end
    end
  end
end

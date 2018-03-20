require 'net/http'
require 'uri'
require 'json'

def send_msg(access_token, recipient, message)
	uri = URI.parse("https://graph.facebook.com/v2.6/me/messages?access_token=#{access_token}")
	request = Net::HTTP::Post.new(uri)
	request.content_type = "application/json"
	request.body = JSON.dump({
	  "messaging_type" => "UPDATE",
	  "recipient" => {
	    "id" => recipient
	  },
	  "message" => {
	    "text" => message
	  }
	})

	req_options = {
	  use_ssl: uri.scheme == "https",
	}

	response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
	  http.request(request)
	end

	puts response.code
	puts response.body
end

# ===> 1 minute = 60 secondes _ 8 msgs sur 14h _ 14/8 = 1,75 _ Interval aleatoire entre 1h et 2,5 h
# ===> 1h = 3600 secondes, 2h30 = 9000 secondes
# ===> 14h = 50 400 secs

access_token = "EAAIdD3Re5ZC8BABMdF8ZB51w4n8QZCEVWHOLZB7t5RwZCY5MtelXzZAzhLZAAmNKucuTleMPKZCBttNmcqqVFQOIuFrunL5oyzDpceealPh7HvN52GSabKRm2QShKnVZBSsZAURvZCtX4qndU7kgPytoZAkkZBxjetawtnNZBkmYZBCZCpb26QZDZD"
recipient = "1805001089562157"

tableau_intervalles = []
total = 0
begin
	nouveau_temps = (3600 + rand(5400))
	total = total + nouveau_temps
	tableau_intervalles << nouveau_temps
until total > 50400

tableau_intervalles.each do |i|
	sleep(i)
	send_msg(access_token, recipient, "Dsl de te deranger ! Juste 3 questions : Tu fais quoi ? Comment tu te sens ? Es tu dans un etat de flow ?")
end

send_msg(access_token, recipient, "C'est la fin de la journée ! N'oublie pas de me relancer demain matin")
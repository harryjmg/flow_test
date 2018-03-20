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


# Etape 1 : Definir intervalles de minutes
# Etape 2 : Mettre les intervalles dans un tableau
# Etape 3 : Iterer dans le tableau

access_token = "EAAIdD3Re5ZC8BABMdF8ZB51w4n8QZCEVWHOLZB7t5RwZCY5MtelXzZAzhLZAAmNKucuTleMPKZCBttNmcqqVFQOIuFrunL5oyzDpceealPh7HvN52GSabKRm2QShKnVZBSsZAURvZCtX4qndU7kgPytoZAkkZBxjetawtnNZBkmYZBCZCpb26QZDZD"
recipient = "1805001089562157"

send_msg(access_token, recipient, "Hey")
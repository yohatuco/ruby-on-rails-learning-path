class PokemonApi
    def self.to_json
      pokemons = []
  
        response = HTTParty.get("https://pokeapi.co/api/v2/pokemon?limit=20&offset=0")
        response = JSON.parse(response.body)
        response.each do |k, value|
            if k == "results"
                value.each do |key, val|
                response = HTTParty.get(key["url"])
                response = JSON.parse(response.body)
                puts key["url"]  
                pokemons.push(response)
                end
            end
        end

        pokemons.map do |poke|
            puts poke['sprites']['other']['dream_world']["front_default"]
            puts poke['base_experience']
            puts poke['forms'][0]['name']
            puts poke['weight']
            puts poke['height']
            abilities = poke['abilities']
            stats = poke['stats']
            abilities.map do |ability|
                puts ability
                puts ability['ability']['name']
                response = HTTParty.get(ability['ability']["url"])
                puts response["id"]
            end
            stats.map do |stat|
                puts stat
                puts stat['stat']['name']
                response = HTTParty.get(stat['stat']["url"])
                puts response["id"]
            end
            puts poke['id']
        end
    end
end
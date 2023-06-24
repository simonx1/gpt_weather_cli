require 'openai'
require 'open-weather-ruby-client'

class OpenAIClient

  attr_accessor :client, :ow_client

  def initialize(api_key, ow_api_key)
    @client = OpenAI::Client.new(
      access_token: api_key,
      request_timeout: 240
    )

    @ow_client = OpenWeather::Client.new(
      api_key: ow_api_key
    )    
  end

  def chat(prompt)
    response = client.chat(
      parameters: {
        model: "gpt-4-0613",
        messages: [
          {role: "system", content: "You are a helpful assistant."},
          {role: "user", content: prompt}
        ],
        functions: [
          {
            name: "get_current_weather",
            description: "Get the current weather in a given location",
            parameters: {
              type: :object,
              properties: {
                location: {
                  type: :string,
                  description: "The city and state, e.g. San Francisco, CA",
                },
                unit: {
                  type: "string",
                  enum: %w[celsius fahrenheit],
                },
              },
              required: ["location"],
            },
          },
        ],
      }
    )

    message = response.dig("choices", 0, "message")

    # puts "\n\n\n #{response.inspect} \n\n\n"

    if message["role"] == "assistant" && message["function_call"]
      function_name = message.dig("function_call", "name")
      args =
        JSON.parse(
          message.dig("function_call", "arguments"),
          { symbolize_names: true },
        )
    
      case function_name
      when "get_current_weather"
        data = get_current_weather(**args)
        
        {
          name: data.name, # => 'London'
          time: data.dt, # => Time
          feels_like: data.main.feels_like_c, # => 277.73
          humidity: data.main.humidity, # => 81
          pressure: data.main.pressure, # => 1005
          temp: data.main.temp_c, # => 282.57
          temp_max: data.main.temp_max_c, # => 10, degrees Celcius
          temp_min: data.main.temp_min_c, # => 10, degrees Celcius
        }
      end
    else
      message["content"]
    end
  end

  def get_current_weather(location:, unit: "celsius")
    data = ow_client.current_weather(city: location)
    data
  end  
end

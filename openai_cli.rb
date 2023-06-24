require 'thor'
require_relative 'openai_client'

class OpenAICLI < Thor

  desc "ask PROMPT", "Ask a question to the OpenAI API"
  def ask(prompt)
    begin
      client = OpenAIClient.new(ENV['OPENAI_API_KEY'], ENV['OPENWEATHER_API_KEY'])
      response = client.chat(prompt)
      puts "\e[33m#{response}\e[0m"
    rescue StandardError => e
      puts "\e[31mError: #{e.message}\e[0m"
    end
  end
end

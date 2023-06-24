gem install bundler
bundle init
echo "gem 'openai'" >> Gemfile
echo "gem 'thor'" >> Gemfile
bundle install --path vendor/bundle

export OPENAI_API_KEY="your_openai_api_key_here"
ruby main.rb ask "What is the capital of France?"

Core classes, functions, and methods:

1. `openai_client.rb`: Contains the OpenAIClient class which handles communication with the OpenAI API.
   - `initialize`: Initializes the OpenAIClient with the API key.
   - `chat`: Sends a message to the OpenAI API and returns the response.

2. `openai_cli.rb`: Contains the OpenAICLI class which inherits from Thor and defines the command line interface.
   - `initialize`: Initializes the OpenAICLI with an instance of OpenAIClient.
   - `ask`: The Thor command that takes a user prompt and displays the response from the OpenAI API.

3. `main.rb`: The entry point of the application that sets up the OpenAICLI and starts the command line interface.

Now, let's create the content of each file.

openai_client.rb

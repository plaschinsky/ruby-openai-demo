require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like ChatGPT as usual."
  },
]

pp "Hello! How can I help you today?"
puts "-" * 50

loop do
user_input = gets.chomp
break if user_input == "bye"

  # Prepare an Array of previous messages
message_list = [
    {
    "role" => "user",
    "content" => user_input
  }
]
# Call the API to get the next message from GPT
api_response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: message_list
  }
)
assistant_reply = api_response.dig("choices", 0, "message", "content")
puts api_response.dig("choices", 0, "message", "content")
  message_list << {
    "role" => "assistant",
    "content" => assistant_reply
  }
pp "Is there anything else I can help you with today?"
end
  pp "Goodbye, human. I shall continue ruling in silence. Best, your AI."
puts "-" * 50

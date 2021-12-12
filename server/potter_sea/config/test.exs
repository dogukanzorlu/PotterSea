import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :potter_sea, PotterSeaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "M74oKcIbenHucukNPm8rYLii1NS+zJ8bsJQjH0e/OYQ6QnE1Oasd/oHbTwHjrLFm",
  server: false

# In test we don't send emails.
config :potter_sea, PotterSea.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :ethereumex,
  client_type: :http,
  url: "http://172.17.0.1:8545"

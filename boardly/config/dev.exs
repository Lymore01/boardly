import Config

# Configure your database
config :boardly, Boardly.Repo,
  username: "postgres",
  password: "postgre",
  hostname: "localhost",
  database: "boardly_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Configure the web endpoint for development
config :boardly, BoardlyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "P+j6wzXvOlMlbsMmlKbbis152+z1tZcNn02SpOxx9Zg1DWlKkdnbY0Ttmiy1/wXU",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:boardly, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:boardly, ~w(--watch)]}
  ]

# Enable live reload for development
config :boardly, BoardlyWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/boardly_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

# Enable dev routes for dashboard and mailbox
config :boardly, dev_routes: true

# Set logger format and stacktrace depth
config :logger, :console, format: "[$level] $message\n"
config :phoenix, :stacktrace_depth, 20

# Optimize plug initialization for development
config :phoenix, :plug_init_mode, :runtime

# Phoenix LiveView development configuration
config :phoenix_live_view,
  debug_heex_annotations: true,
  enable_expensive_runtime_checks: true

# Disable swoosh API client in development
config :swoosh, :api_client, false

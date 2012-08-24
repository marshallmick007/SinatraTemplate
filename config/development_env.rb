
if ENV['RACK_ENV'] || "development" == "development"
  ENV['ENV_KEY'] = "value"

  # Rake and Guard variables
  ENV["LESS_IMPORT_PATH"] = 'assets/less/inc'
  ENV["LESS_ASSET_DIR"] = 'assets/less'
  ENV["CSS_OUTPUT_DIR"] = 'public/css'
end

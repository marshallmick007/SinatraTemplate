
if ENV['RACK_ENV'] || "development" == "development"
  ENV['ENV_KEY'] = "value"
end

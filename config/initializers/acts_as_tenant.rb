ActsAsTenant.configure do |config|
  config.require_tenant = false # tenant lookup in application controller will be nil and give full DB access
  # see other config options here: https://github.com/ErwinM/acts_as_tenant
  # config.fallback_to_primary = true
end
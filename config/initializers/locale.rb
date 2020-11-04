# config/initializers/locale.rb
 
# Where the I18n library should search for translation files
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
 
# Permitted locales available for the application
I18n.config.available_locales = [:en, :ja]
I18n.enforce_available_locales = true
# Set default locale to something other than :en
I18n.default_locale = :ja
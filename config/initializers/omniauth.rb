Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,'KEY', 'SECRET',
             :scope => 'publish_stream,user_about_me,read_stream', :display => 'popup'
end

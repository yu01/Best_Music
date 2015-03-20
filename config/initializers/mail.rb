ActionMailer::Base.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587,
    :enable_starttls_auto => true,
    :user_name => "tencet@yandex.ru",
    :password  => "va3DEr2tBDl6ZqL1FDiJLg",
    :authentication => 'login'
  }

ActionMailer::Base.delivery_mathod = :smtp
ActionMailer::Base.default charset: "utf-8"

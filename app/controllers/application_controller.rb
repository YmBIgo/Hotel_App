require "gmail"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :locale

  protected
  # 
  def initialize_or_find_remainroom(date)
  	remainroom	= Remainroom.find_by(:room_date => date)
  	if remainroom == nil
  		plan_text = "{"; price_text = "{";
  		Plan.all.each do |plan|
  			plan_text += plan.id.to_s + "=> 0,"
        price_text += plan.id.to_s + "=> " + plan.price.to_s + ","
  		end
  		plan_text += "}"; price_text += "}"
  		new_remainroom = Remainroom.new(:room_date => date, :room_ids => plan_text, :room_prices => price_text)
  		new_remainroom.save!
  		return new_remainroom
  	else
  		return remainroom
  	end
  end
  # gmail
  def send_mail(email, url)
    # should not use raw password !!!!
    username = "megufuji123@gmail.com"
    password = ENV["GMAIL_PASS"]

    gmail = Gmail.new(username, password)
    ret = gmail.deliver do
      to email
      subject "ご予約ありがとうございました"
      html_part do
        content_type "text/html; charset=UTF-8"
        body "<h4>ご予約ありがとうございました</h4
<hr>
<p>予約内容は<a href='#{url}'>#{url}</a>からご確認できます
<br>
当日のご来泊、心よりお待ちしております。
</p>"
      end
    end
    gmail.logout
  end

  # locate
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  def locale
    @locale ||= params[:locale] ||= I18n.default_locale
  end
  def default_url_options(options={})
    options.merge(locale: locale)
    # { :locale => I18n.locale }
  end

end

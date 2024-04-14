module ApplicationHelper
    def gravatar_for(user, options = { size: 80 })
      gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
      size = options[:size]
      gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
      image_tag(gravatar_url, alt: user.name, class: "img-circle")
    end
    def flash_class(type)
      case type
      when 'success'
        'alert-success'
      when 'danger'
        'alert-danger'
      when 'alert'
        'alert-warning'
      when 'notice'
        'alert-info'
      else
        "alert-#{type}"
      end
    end
end

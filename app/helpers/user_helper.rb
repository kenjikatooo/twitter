module UserHelper
    #引数で与えられたユーザーのgravatar画像を返す
    def gravatar_for(user)
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        #image_tagを使ってgravatar_urlを引っ張ってくる
        image_tag(gravatar_url, alt: user.name, class:"gravatar")
    end
end

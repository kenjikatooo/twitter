module ApplicationHelper

    #ページごとの完全なタイトルを返す
    #full_titleメソッドを作成
    def full_title(page_title='')
        base_title = "twitter"
        if page_title.empty?
            base_title
        else
            page_title+ " | "+ base_title
        end
    end
end

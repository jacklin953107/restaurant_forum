module ApplicationHelper
  def show_img(img)
    for img_id in 0..7
      include_path = '/'+img_id.to_s+'.jpg'
      return image_tag(('/seed_img'+include_path), class: "img-responsive center-block") if image_path(img).include?(include_path)
    end
    '<span class="glyphicon glyphicon-picture"></span>[沒有圖片]'.html_safe
  end
end

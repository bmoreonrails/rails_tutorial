class ClassBlock < Liquid::Block
  def initialize(tag_name, text, tokens)
    super
  end

  def render(context)
    content = Kramdown::Document.new(super).to_html
    "<div class='#{@tag_name}'> #{content} </div>"
  end
end

Liquid::Template.register_tag('protip', ClassBlock)


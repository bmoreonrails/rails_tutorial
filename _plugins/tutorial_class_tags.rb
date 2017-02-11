class ClassBlock < Liquid::Block
  def initialize(tag_name, text, tokens)
    super
    @class_name = tag_name
  end

  def render(context)
    original_content = super
    parsed_content = convert(content: original_content, context: context)
    "<div class='#{@class_name}'>#{parsed_content}</div>"
  end

  private

  def convert(content: , context: )
    site = context.registers[:site]
    converter = site.find_converter_instance(::Jekyll::Converters::Markdown)
    converter.convert(content)
  end
end

Liquid::Template.register_tag('aside', ClassBlock)
Liquid::Template.register_tag('protip', ClassBlock)
Liquid::Template.register_tag('sectionheader', ClassBlock)
Liquid::Template.register_tag('steps', ClassBlock)
Liquid::Template.register_tag('list', ClassBlock)


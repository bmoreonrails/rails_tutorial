class SectionHeaderTag < Liquid::Tag
  def initialize(tag_name, text, tokens)
    super
  end

  def render(context)
     output = "<div class='section_header'>"
  end
end
Liquid::Template.register_tag('section_header', SectionHeaderTag)

class EndSectionHeaderTag < Liquid::Tag
  def initialize(tag_name, text, tokens)
    super
  end

  def render(context)
    output = "</div>"
  end
end
Liquid::Template.register_tag('endsection_header', EndSectionHeaderTag)

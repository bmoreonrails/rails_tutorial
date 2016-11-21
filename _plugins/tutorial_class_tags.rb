class Div < Liquid::Tag
  def initialize(tag_name, text, tokens)
    @tag_name = tag_name
    super
  end

  def render(context)
     output = "<div class='#{@tag_name}'>"
  end
end

class EndDiv < Liquid::Tag
  def initialize(tag_name, text, tokens)
    super
  end

  def render(context)
    output = "</div>"
  end
end

Liquid::Template.register_tag('sectionheader', Div)
Liquid::Template.register_tag('endsectionheader', EndDiv)

Liquid::Template.register_tag('protip', Div)
Liquid::Template.register_tag('endprotip', EndDiv)

Liquid::Template.register_tag('steps', Div)
Liquid::Template.register_tag('endsteps', EndDiv)

Liquid::Template.register_tag('aside', Div)
Liquid::Template.register_tag('endaside', EndDiv)

Liquid::Template.register_tag('screenshot', Div)
Liquid::Template.register_tag('endscreenshot', EndDiv)

module ApplicationHelper
  def markdown(text)
    render_options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow' }
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(render_options),
                                       no_intra_emphasis: true,
                                       fenced_code_blocks: true,
                                       disable_indented_code_blocks: true,
                                       autolink: true,
                                       tables: true,
                                       underline: true,
                                       highlight: true,
                                       strikethrough: true,
                                       superscript: true,
                                       space_after_headers: true
                                      )
    return markdown.render(text).html_safe
  end
end

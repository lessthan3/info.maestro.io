exports.Template = (footer) ->
  return unless footer
  {copyright, links} = footer

  if links.length > 0
    div '.links', ->
      for {link, icon} in links
        a href: link, ->
          i ".icon-#{icon}"

  if copyright
    div '.copyright', ->
      text '©'
      text copyright

exports.Template = ({logo, title, versions}) ->

  if logo
    a href: '/', ->
      img src: logo

  if title
    h1 '.page-title', ->
      title

  if versions?.length > 0
    for version in versions
      div '.version', ->
        {title, date, content} = version

        if title
          div '.header', ->
            span '.title', -> title

            if date
              div '.date', ->
                date

        if content
          div '.notes', ->
            raw content

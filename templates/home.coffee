exports.Template = (data) ->
  return unless data
  {banner, intro, video, features, use_cases, channels, webinar, contact} = data

  if banner
    {background, logo, title, subtitle, button_text} = banner

    div '.banner', style: "background-image: url(#{background})", ->

      if logo
        div '.logo', ->
          img src: logo

      div '.banner-content', ->
        if title
          div '.title', ->
            title

        if subtitle
          div '.subtitle', ->
            subtitle

        if button_text
          div '.call-to-action', ->
            button_text

  if intro
    {active, title, description, image} = intro

    if active
      div '.section left', ->

        if title
          h1 ->
            title

        if description
          p ->
            description

        if image
          div '.image', ->
            img '.full', src: image

  if video
    {active, title, embed} = video

    if active

      div '.section', ->

        if title
          h1 ->
            title

        if embed
          div '.embed', ->
            raw embed

  if features
    {active, title, description, features} = features

    if active
      div '.section', ->

        if title
          h1 ->
            title

        if description
          p ->
            description

        if features.length > 0
          div '.features', ->

            for feature in features
              {name, icon, description} = feature
              div '.feature', ->
                i ".icon-#{icon}"
                h3 -> name
                p -> description

  if use_cases
    {active, title, description, image, examples} = use_cases

    if active
      div '.section', ->

        if title
          h1 ->
            title

        if description
          p ->
            description

        div '.examples', ->

          for example in examples or []
            {image, name, client} = example or {}
            div '.example', style: "background-image: url(#{image})", ->
              div '.overlay'
              div '.title', -> name

              if client
                div '.case-study', ->
                  h1 -> client.name
                  img src: client.image
                  p -> client.description

  if channels
    {active, title, description, channels} = channels

    if active
      div '.section', ->

        if title
          h1 ->
            title

        if description
          p ->
            description

        div '.channels', ->

          for channel in channels
            {name, description, image, link} = channel

            div '.channel', ->
              a '.link', href: link, ->
                div '.image', ->
                  img src: image
              div '.name', -> name
              div '.description', -> description

  if webinar
    {active, title, subtitle, time} = webinar
    if active

      div '.section webinar', ->
        if title
          h1 -> title

        if subtitle
          h4 '.subtitle', -> subtitle

        if time
          h3 '.time', -> time

        # get next wednesday at 11am PT
        d = new Date()
        current_day_of_week = d.getDay()
        wednesday = 3
        days_until_wednesday = (wednesday + (7 - current_day_of_week)) % 7
        d.setDate d.getDate() + days_until_wednesday
        d.setUTCHours 11 + 7 # UTC offset
        d.setUTCMinutes 0
        d.setUTCSeconds 0
        d.setUTCMilliseconds 0

        div '.add-to-calendar', data: {
          'header-subtitle': subtitle or ''
          'header-title': 'Maestro Webinar'
          'location': 'http://www.maestro.io/webinar'
          'start-time': d
          'title': 'Maestro Webinar'
        }, ->
          i '.icon-calendar'
          span -> 'ADD TO CALENDAR'

  if contact
    {title, description, address, phone, email} = contact

    div '.section left', ->
      if title
        h1 ->
          title

      if description
        p ->
          description

      div '.contact', ->

        div '.form', ->
          div '.name', ->
            input type: 'text', name: 'name', placeholder: 'Name'
          div '.email', ->
            input type: 'text', name: 'email', placeholder: 'Email'
          div '.message', ->
            textarea name: 'message', placeholder: 'Message'
          div '.submit', 'data-status': 'init', ->
            'Send Message'

        div '.info', ->

          if address
            div '.address', ->
              i '.icon-home'
              div -> address

          if phone
            div '.phone', ->
              i '.icon-mobile'
              div -> phone

          if email
            div '.email', ->
              i '.icon-email'
              div -> email

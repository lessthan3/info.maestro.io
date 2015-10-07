class exports.Presenter

  events:
    'click .example': 'openCaseStudy'
    'click .contact .form .submit': 'submitForm'
    'click .banner .call-to-action': 'gotoForm'

  afterRender: ->

    # set the banner to the full height of the window
    $banner = @$el.find '.banner'
    $banner.height 1 * $(window).height()

    # setup the add to calendar button
    $webinar = @$el.find '.webinar'
    $webinar.find('.add-to-calendar').addToCalendar {
      onOpen: ->
        lt3.track 'add-webinar-to-calendar'
    }

  # quick call-to-action button to jump to the contact form
  gotoForm: ->
    offset = $('.contact').offset().top - 200
    $('body').animate {
      scrollTop: offset
    }

  # open a case study with more information in a modal
  openCaseStudy: (e) ->
    $example = $ e.currentTarget
    $case_study = $example.find '.case-study'
    dobi.modal.open {
      class: 'case-study'
      html: $case_study.html()
    }

  # validate and submit the contact form
  submitForm: ->

    # grab dom elements
    $btn = @$el.find '.contact .form .submit'
    $name = @$el.find '.contact .form .name input'
    $email = @$el.find '.contact .form .email input'
    $message = @$el.find '.contact .form .message textarea'

    # make sure we aren't already sending
    return if $btn.attr('data-status') isnt 'init'

    # target email
    target = @ref.get('contact.email').val()

    # form info
    name = $name.val()
    email = $email.val()
    message = $message.val()

    # validate input
    return dobi.alert 'Please enter a name' if not name
    return dobi.alert 'Please enter a email' if not email
    return dobi.alert 'Please enter a message' if not message

    # send request
    $.ajax {
      url: "//formspree.io/#{target}"
      method: 'POST'
      data: {name, email, message}
      dataType: 'json'
      error: (xhr, status, err) ->
        $btn.attr 'data-status', 'error'
        $btn.text "Error submitting. Please contact us directly at #{target}"
      success: (data, status, xhr) ->
        $btn.attr 'data-status', 'success'
        $btn.text "Thank You! We'll reach out to you shortly."
        setTimeout ( ->
          $name.val ''
          $email.val ''
          $message.val ''
          $btn.attr 'data-status', 'init'
          $btn.text 'Send Message'
        ), 3000

        # track analytics
        lt3.track 'contact-form', '', email
    }

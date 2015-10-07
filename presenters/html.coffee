class exports.Presenter

  hooks:
    'before:render': 'appendCSS'

  appendCSS: ->
    @style.remove() if @style
    css = @ref.get('css').val()
    @style = $.appendCSS css if css

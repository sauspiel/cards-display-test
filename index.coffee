require './stylesheets/styles.scss'

require.ensure [], () ->
  require './stylesheets/assets.scss'

  $ ->
    interval = null
    useSVGs = yes
    useImgTag = no
    decks = ["fr", "de", "tn", "by", "fn"]
    colors = "E,G,H,S".split(',')
    cards = "7,8,9,U,O,K,X,A".split(',')

    drawCards = ->
      count = 12
      ext = if useSVGs then ".svg" else "@2x.png"
      # deck = decks[~~(Math.random() * decks.length)]
      deck = "tn"
      $('#container').html('')
      $('#container').attr('class', '')
      $('#container').addClass("deck_#{deck}")

      for i in [0...count]
        color = colors[~~(Math.random() * colors.length)]
        card = cards[~~(Math.random() * cards.length)]
        cardID = color + card
        if useImgTag
          url = require("url!./stylesheets/blocks/imgs/#{deck}/#{cardID}_#{deck}#{ext}")
          $cardEl = $("<img class='card card_#{cardID}' src='#{url}'>")
        else
          $cardEl = $("<div class='card card_#{cardID}'>")
        $cardEl.css
          'transform': "translate(#{i * 75}px, 0) rotate(#{-6 + Math.random() * 12}deg)"
          'zIndex': i+1
        $('#container').append($cardEl)

    drawCards()

    $('.start').on "click", ->
      interval = window.setInterval drawCards, 0

    $('.stop').on "click", ->
      window.clearInterval(interval)

    toggleViews = ->
      useSVGs = not useSVGs
      if useSVGs
        $('.btn-pngs-svgs').text('SVGs')
        $('body').addClass("deck_svg")
        $('body').removeClass("deck_png")
      else
        $('.btn-pngs-svgs').text('PNGs')
        $('body').addClass("deck_png")
        $('body').removeClass("deck_svg")
      drawCards()

    toggleMethod = ->
      useImgTag = not useImgTag
      if useImgTag
        $('.btn-method').text('IMG')
      else
        $('.btn-method').text('DIV')
      drawCards()

    $('.btn-pngs-svgs').on "click", toggleViews
    toggleViews()

    $('.btn-method').on "click", toggleMethod
    toggleMethod()




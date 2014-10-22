require './stylesheets/styles.scss'

require.ensure [], () ->
  require './stylesheets/assets.scss'


  $ ->
    cache = {} # Key/value storage for cards
    interval = null
    useSVGs = yes
    useImgTag = 0
    decks = ["fr", "de", "tn", "by", "fn"]
    colors = "E,G,H,S".split(',')
    cards = "7,8,9,U,O,K,X,A".split(',')
    counter = 0

    cacheCards = ->
      deck = "tn"
      for color in colors
        do (color) ->
          for card in cards
            do (card) ->
              cardID = color + card
              url = require("file!./stylesheets/blocks/imgs/#{deck}/#{cardID}_#{deck}.svg")
              console.log url
              img = new Image
              img.onload = ->
                canvas = document.createElement('canvas')
                canvas.width = img.width
                canvas.height = img.height
                console.log img.width, img.height
                ctx = canvas.getContext("2d")
                ctx.drawImage(img, 0, 0)
                cache[cardID] = canvas.toDataURL()
                console.log cache[cardID]
                counter++
                if counter >= 32
                  t2 = Date.now()
                  console.log "All loaded in #{t2-t1}ms"

              img.src = url # Kick loading

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
        switch useImgTag
          when 0
            url = require("url!./stylesheets/blocks/imgs/#{deck}/#{cardID}_#{deck}#{ext}")
            $cardEl = $("<img class='card card_#{cardID}' src='#{url}'>")
          when 1
            $cardEl = $("<div class='card card_#{cardID}'>")
          when 2
            $cardEl = $("<div class='card'>")
            $cardEl.css
              backgroundImage: "url(#{cache[cardID]})"

        $cardEl.css
          'transform': "translate(#{i * 75}px, 0) rotate(#{-6 + Math.random() * 12}deg)"
          'zIndex': i+1
        $('#container').append($cardEl)

    t1 = Date.now()
    console.log "Started caching"
    cacheCards()

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
      useImgTag = if useImgTag >= 2 then 0 else useImgTag + 1
      switch useImgTag
        when 0
          $('.btn-method').text('IMG')
        when 1
          $('.btn-method').text('DIV')
        when 2
          $('.btn-method').text('Cache')

      drawCards()

    $('.btn-pngs-svgs').on "click", toggleViews
    toggleViews()

    $('.btn-method').on "click", toggleMethod
    toggleMethod()




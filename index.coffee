require './stylesheets/styles.scss'

require.ensure [], () ->
  require './stylesheets/assets.scss'

  $ ->
    interval = null
    decks = ["fr", "de", "tn", "by", "fn"]
    colors = "E,G,H,S".split(',')
    cards = "7,8,9,U,O,K,X,A".split(',')

    drawCards = (count = 12) ->
      deck = decks[~~(Math.random() * decks.length)]
      $('#container').html('')
      $('#container').attr('class', '')
      $('#container').addClass("deck_#{deck}")

      for i in [0...count]
        color = colors[~~(Math.random() * colors.length)]
        card = cards[~~(Math.random() * cards.length)]
        cardID = color + card
        $cardEl = $("<div class='card card_#{cardID}'>")
        $cardEl.css
          'transform': "translate(#{i * 75}px, 0) rotate(#{-6 + Math.random() * 12}deg)"
          'zIndex': i+1
        $('#container').append($cardEl)

    drawCards(12)

    $('.start').on "click", ->
      interval = window.setInterval drawCards, 0

    $('.stop').on "click", ->
      window.clearInterval(interval)


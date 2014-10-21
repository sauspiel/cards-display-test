require './stylesheets/styles.scss'

require.ensure [], () ->
  require './stylesheets/assets.scss'

  $ ->
    decks = ["fr", "de", "tn", "by", "fn"]
    colors = "E,G,H,S".split(',')
    cards = "7,8,9,U,O,K,X,A".split(',')
    for deck in decks
      $deck = $("<div class='deck deck_#{deck}'>")
      for color in colors
        $color = $("<div class='color'>")
        for card in cards
          cardID = color + card
          $cardEl = $("<div class='card card_#{cardID}'>")
          $color.append($cardEl)
        $deck.append($color)
      $('#container').append($deck)

    tick = ->
      $('.card').each (idx, card) ->
        $(card).css('transform', "rotate(#{-6 + Math.random() * 12}deg) translate3d(0,0,0)")

    window.setInterval tick, 1000


require './stylesheets/styles.scss'

require.ensure [], () ->
  require './stylesheets/assets.scss'
  $ ->
    decks = ["fr", "de", "tn"]
    colors = "E,G,H,S".split(',')
    cards = "7,8,9,U,O,K,X,A".split(',')
    for deck in decks
      $deck = $("<div class='deck deck_#{deck}'>")
      for color in colors
        for card in cards
          cardID = color + card
          $cardEl = $("<div class='card card_#{cardID}'>")
          $deck.append($cardEl)
      $('#container').append($deck)

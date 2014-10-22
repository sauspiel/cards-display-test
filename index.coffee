do -> Array::shuffle ?= ->
  for i in [@length-1..1]
    j = Math.floor Math.random() * (i + 1)
    [@[i], @[j]] = [@[j], @[i]]
  @

require './stylesheets/styles.scss'

require.ensure [], () ->
  require './stylesheets/assets.scss'

  $ ->
    interval = null
    cards = ["E7", "G8", "H9", "SU", "EO", "HA", "GX", "EK", "H9", "SA", "GU"]
    deck = "by"

    drawCards = ->
      $('#container').html('')
      $('#container').attr('class', '')
      $('#container').addClass("deck_#{deck}")
      for card, i in cards.shuffle()
        $cardEl = $("<div class='card card_#{card}'>")
        $cardEl.css
          'transform': "translate(#{i * 75}px, 0) rotate(#{-6 + Math.random() * 12}deg)"
          'zIndex': i+1
        $('#container').append($cardEl)
    drawCards()

    $('.start').on "click", ->
      interval = window.setInterval drawCards, 0

    $('.stop').on "click", ->
      window.clearInterval(interval)

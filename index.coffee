require './stylesheets/styles.scss'

require.ensure [], () ->
  require './stylesheets/assets.scss'

  $ ->
    interval = null
    useImgTag = no
    decks = ["fr", "de", "tn", "by", "fn"]
    colors = "E,G,H,S".split(',')
    cards = "7,8,9,U,O,K,X,A".split(',')
    deck = "tn"

    $("#initial_cards").addClass("deck_#{deck}")
    for color in colors
      for card in cards
        cardID = color + card
        $card = $("<div class='card_#{cardID}' style='display:none; width:0px; height:0px;'>")
        $("#initial_cards").append $card

    setTimeout (->
      $("#initial_cards").remove()
    ), 1000

    drawCards = ->
      count = 12
      ext = ".svg"
      # deck = decks[~~(Math.random() * decks.length)]
      $('#container').html('')
      $('#container').attr('class', '')
      $('#duplicates').attr('class', '')
      $('#container').addClass("deck_#{deck}")
      $('#duplicates').addClass("deck_#{deck}")
      $('#tests').html('')

      for i in [0...count]
        color = colors[~~(Math.random() * colors.length)]
        card = cards[~~(Math.random() * cards.length)]
        cardID = color + card
        $cardEl = $("<div class='card card_#{cardID}'>")
        $cardEl.css
          'width': 226
          'height': 340
          'transform': "translate(#{i * 75}px, 0) rotate(#{-6 + Math.random() * 12}deg)"
          'zIndex': i+1
        $('#container').append($cardEl)

    drawCards()

    $('.start').on "click", ->
      interval = window.setInterval drawCards, 0

    $('.stop').on "click", ->
      window.clearInterval(interval)

    $('.duplicate').on "click", ->
      $("#duplicates").html("")
      $("#container .card").each ->
        $("#duplicates").append $("<div class='#{$(this).attr('class')}' style='#{$(this).attr('style')}'>")

    $('.heal').on "click", ->
      $("#tests").html("")
      $("#container .card").each ->
        url = $(this).css('background-image').replace('url("', '').replace('")', '')
        $("#tests").append $("<object data='#{url}' type='image/svg+xml'>")
        # window.scrollBy(0, 0)

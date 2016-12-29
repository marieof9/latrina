$ ->
  App.latrinas = App.cable.subscriptions.create {"channel": "LatrinasChannel", "name":$('#latrina').data('latrina')},
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      if data['locked']
        $('body').removeClass('open')
        $('body').addClass('locked')
      else
        $('body').removeClass('locked')
        $('body').addClass('open')

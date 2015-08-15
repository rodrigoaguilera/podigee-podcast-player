$ = require('../../vendor/javascripts/jquery.1.11.0.min.js')
IframeResizer = require('./iframe_resizer.coffee')

class Iframe
  constructor: (@elem)->
    @id = Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)
    @dataVariableName = $(@elem).data('configuration')
    @url = "podigee-podcast-player.html?configuration=#{@dataVariableName}&id=#{@id}"

    @buildIframe()
    @setupListeners()
    @replaceElem()

  buildIframe: ->
    @iframe = document.createElement('iframe')
    @iframe.id = @id
    @iframe.scrolling = 'no'
    @iframe.src = @url
    @iframe.style.border = '0'
    @iframe.style.overflowY = 'hidden'
    @iframe.style.transition = 'height 100ms linear'
    @iframe.height = '173px'
    @iframe.width = '100%'
    @iframe

  setupListeners: ->
    IframeResizer.listen('resizePlayer', $(@iframe))

  replaceElem: ->
    @elem.parentNode.replaceChild(@iframe, @elem)


class Embed
  constructor: ->
    players = []
    elems = $('.podigee-podcast-player')

    return if elems.length == 0

    for elem in elems
      players.push(new Iframe(elem))

    window.podigeePodcastPlayers = players

module.exports = Embed

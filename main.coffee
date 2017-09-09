APP = undefined

APP = {}

APP.devHeroAnimate = ->
  animationElementArray = $(document).find('[devhero-animate]')
  $.each animationElementArray, (index, element) ->

    configRaw = $(element).attr('devhero-animate')
    config = $.parseJSON(configRaw)

    if !config.direction?
      config.direction = 'up'
    if !config.range?
      config.range = 0
    if !config.offset?
      config.offset = 30
    if config.range == 0
      config.range = 1
    if config.direction == 'up'
      direction = 1
    else if config.direction == 'down'
      direction = -1

    posTopOfElement = $(element).offset().top

    AnimationArea = {}
    AnimationArea.posX = posTopOfElement - (windowHeight * (config.offset / 100))
    AnimationArea.posY = AnimationArea.posX + windowHeight

    $(window).resize ->
      this.windowHeight = $(window).height()
      this.posTopOfElement = $(element).offset().top
      this.AnimationArea.posX = posTopOfElement - (windowHeight * (config.offset / 100))
      this.AnimationArea.posY = AnimationArea.posX + windowHeight
      checkIfIsInArea(index, WindowArea.posX, WindowArea.posY, AnimationArea.posX, AnimationArea.posY, element, direction, config.range)



    checkIfIsInArea = (index, WindowAreaTop, WindowAreaBottom, AnimationAreaTop, AnimationAreaBottom, element, direction, range) ->
      if(WindowAreaTop < AnimationAreaTop && WindowAreaBottom < AnimationAreaTop) || (WindowAreaTop > AnimationAreaBottom && WindowAreaBottom > AnimationAreaBottom)
        return false
      else
        checkPercentOfScrollArea(index, element, AnimationAreaTop, WindowAreaBottom, direction, range)

    checkPercentOfScrollArea = (index, element, AnimationAreaPosX, WindowAreaPosY, direction, range) ->
      percentView = (WindowAreaPosY - AnimationAreaPosX) / (2 * $(window).height())
      translateElement(element, percentView, direction, range)

    translateElement = (element, percentView, direction, range) ->
      $(element).css('transform', 'translateY(' + (percentView * direction * range) + '%)')

    $(window).scroll ->
      WindowArea = {}
      WindowArea.posX = $(window).scrollTop()
      WindowArea.posY = WindowArea.posX + $(window).height()
      checkIfIsInArea(index, WindowArea.posX, WindowArea.posY, AnimationArea.posX, AnimationArea.posY, element, direction, config.range)

    checkIfIsInArea(index, WindowArea.posX, WindowArea.posY, AnimationArea.posX, AnimationArea.posY, element, direction, config.range)

APP.init = ->
  APP.devHeroAnimate()
  return

$(document).ready ->
  APP.init()
  return

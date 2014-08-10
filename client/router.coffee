Router.configure
  loadingTemplate: 'loading'
  notFoundTemplate: 'notfound'

  load: ->
    $('html, body').animate({ scrollTop: 0 }, 400)
    $('.content').hide().fadeIn(1000)

Router.map ->
  @route 'signin'
  @route 'index', path: '/'
  @route 'dashboard', path: '/'

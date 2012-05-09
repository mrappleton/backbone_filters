# Backbone filters plugin
# Forked from https://github.com/angelo0000/backbone_filters
define (require) ->
  _        = require 'underscore'
  Backbone = require 'backbone'

  filters        = {}
  filters.before = {}
  filters.after  = {}

  filters._runFilters = (filters, fragment, args) ->
    return true if _(filters).isEmpty()

    failingFilter = _(filters).detect((func, filterRoute) ->
      filterRoute = new RegExp(filterRoute) if !_.isRegExp(filterRoute)

      if filterRoute.test(fragment)
        result = (if _.isFunction(func) then func.apply(this, args) else @[func].apply(this, args))
        return (_.isBoolean(result) && result == false)

      false
    , this)

    !failingFilter

  filters.route = (route, name, callback) ->
    Backbone.history || (Backbone.history = new Backbone.History)

    route = @_routeToRegExp(route) if !_.isRegExp(route)

    Backbone.history.route(route, _.bind( (fragment) ->
      args = @_extractParameters(route, fragment)
      if @_runFilters(this.before, fragment, args)
        callback.apply(this, args)
        @_runFilters(this.after, fragment, args)
        @trigger.apply(this, ['route:' + name].concat(args))
    , this))

    _.extend(Backbone.Router.prototype, Backbone.Events, filters)

    Backbone


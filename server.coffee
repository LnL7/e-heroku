http    = require 'http'
path    = require 'path'
express = require 'express'
assets  = require 'connect-assets'

require 'express-namespace'



app = express()

app.configure ->
  app.locals
    root  : process.env.APP_ROOT or __dirname
    port  : process.env.PORT or 3000
    title : 'ExpressJS'

  app.set 'views', path.join app.locals.root, 'views'
  app.set 'view engine', 'jade'

  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()

  app.use express.static path.join app.locals.root, 'public'
  app.use assets()
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler()



routes  = require path.join app.locals.root, 'routes'
app.get '/', routes.index

server = http.createServer app



server.listen app.locals.port, ->
  console.log "NodeJS is listening on port #{ app.locals.port }"

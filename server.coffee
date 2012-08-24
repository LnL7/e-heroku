http    = require 'http'
path    = require 'path'
express = require 'express'
assets  = require 'connect-assets'

require 'express-namespace'



app = express()

app.configure ->
  app.set 'root', process.env.APP_ROOT or __dirname
  app.set 'port', process.env.PORT or 3000

  app.set 'views', path.join app.get('root'), 'views'
  app.set 'view engine', 'jade'

  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.bodyParser()
  app.use express.methodOverride()

  app.use express.static path.join app.get('root'), 'public'
  app.use assets()
  app.use app.router

app.configure 'development', ->
  app.use express.errorHandler()



routes  = require path.join app.get('root'), 'routes'
app.get '/', routes.index

server = http.createServer app



server.listen app.get('port'), ->
  console.log "NodeJS is listening on port #{ app.get('port') }"

http = require 'http'



port = process.env.PORT or 3000

server = http.createServer (req, res) ->
  res.writeHead 200,
    'Content-Type': 'text/plain'

  res.end "NodeJS version #{ process.version } is running"


server.listen port, ->
  console.log "NodeJS is listening on port #{ port }"

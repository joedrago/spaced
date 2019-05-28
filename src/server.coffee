express = require 'express'
app = express()
server = require('http').Server(app)
io = require('socket.io').listen(server)

app.use(express.static(__dirname))

app.get '/', (req, res) ->
  res.sendFile(__dirname + '/index.html')

server.listen 8081, ->
  console.log "Listening on #{server.address().port}"

players = {}

io.on 'connection', (socket) ->
  console.log 'user connected'

  # create a new player and add it to our players object
  players[socket.id] =
    rotation: 0
    x: Math.floor(Math.random() * 700) + 50
    y: Math.floor(Math.random() * 500) + 50
    playerId: socket.id
    team: (Math.floor(Math.random() * 2) == 0) ? 'red' : 'blue'

  # send the players object to the new player
  socket.emit('currentPlayers', players)
  # update all other players of the new player
  socket.broadcast.emit('newPlayer', players[socket.id])

  socket.on 'disconnect', ->
    console.log 'user disconnected'
    # remove this player from our players object
    delete players[socket.id];
    # emit a message to all players to remove this player
    io.emit('disconnect', socket.id)

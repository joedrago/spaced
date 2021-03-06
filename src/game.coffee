addPlayer = (self, playerInfo) ->
  self.ship = self.physics.add.image(playerInfo.x, playerInfo.y, 'ship').setOrigin(0.5, 0.5).setDisplaySize(53, 40)
  if playerInfo.team == 'blue'
    self.ship.setTint(0x0000ff)
  else
    self.ship.setTint(0xff0000)
  self.ship.setDrag(100)
  self.ship.setAngularDrag(100)
  self.ship.setMaxVelocity(200)

preload = ->
  @load.image('ship', 'art/ship1.png')

create = ->
  self = this
  @socket = io()
  @socket.on 'currentPlayers', (players) ->
    Object.keys(players).forEach (id) ->
      if (players[id].playerId == self.socket.id)
        addPlayer(self, players[id])

update = ->

config =
  type: Phaser.AUTO
  parent: 'phaser-example'
  width: 800
  height: 600
  physics:
    default: 'arcade'
    arcade:
      debug: false
      gravity: { y: 0 }
  scene:
    preload: preload
    create: create
    update: update

game = new Phaser.Game(config)

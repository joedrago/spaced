// Generated by CoffeeScript 2.4.1
(function() {
  var addPlayer, config, create, game, preload, update;

  addPlayer = function(self, playerInfo) {
    self.ship = self.physics.add.image(playerInfo.x, playerInfo.y, 'ship').setOrigin(0.5, 0.5).setDisplaySize(53, 40);
    if (playerInfo.team === 'blue') {
      self.ship.setTint(0x0000ff);
    } else {
      self.ship.setTint(0xff0000);
    }
    self.ship.setDrag(100);
    self.ship.setAngularDrag(100);
    return self.ship.setMaxVelocity(200);
  };

  preload = function() {
    return this.load.image('ship', 'art/ship1.png');
  };

  create = function() {
    var self;
    self = this;
    this.socket = io();
    return this.socket.on('currentPlayers', function(players) {
      return Object.keys(players).forEach(function(id) {
        if (players[id].playerId === self.socket.id) {
          return addPlayer(self, players[id]);
        }
      });
    });
  };

  update = function() {};

  config = {
    type: Phaser.AUTO,
    parent: 'phaser-example',
    width: 800,
    height: 600,
    physics: {
      default: 'arcade',
      arcade: {
        debug: false,
        gravity: {
          y: 0
        }
      }
    },
    scene: {
      preload: preload,
      create: create,
      update: update
    }
  };

  game = new Phaser.Game(config);

}).call(this);

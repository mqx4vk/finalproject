extends Node2D
@onready var block : CollisionShape2D = $Block

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	if $Player1.player1 and $Player1.smile:
		$Bee.hide()
		block.hide()
		
		

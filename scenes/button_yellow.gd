extends StaticBody2D
#Red Button Variables

@onready var yellow_sprite: AnimatedSprite2D = $yellow_sprite
@onready var yellow_collider_top: CollisionShape2D = $yellow_collider_top




#red buttona
#radius = 6px
#height = 80px
#position y = -86px

#blue button
#radius = 10
#height = 120
#position y = -93

#yellow button
#radius = 
#height = 
#position y = 

var OnButton := false

func _on_yellow_checker_body_entered(body: Node2D) -> void:
	OnButton = true

func _on_yellow_checker_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

	
func _physics_process(delta: float) -> void:
	if OnButton:
		yellow_sprite.play("down")
		yellow_collider_top.position.y = 53
		yellow_collider_top.shape.radius = 12
		yellow_collider_top.shape.height = 112
		
		
	

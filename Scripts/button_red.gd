extends StaticBody2D
#Red Button Variables

@onready var red_sprite: AnimatedSprite2D = $red_sprite
@onready var red_collider_top: CollisionShape2D = $red_collider_top




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


func _on_top_checker_body_entered(body: Node2D) -> void:
	OnButton = true
	
	
	


func _on_top_checker_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
	
func _physics_process(delta: float) -> void:
	if OnButton:
		red_sprite.play("down")
		red_collider_top.position.y = -86
		red_collider_top.shape.radius = 6
		red_collider_top.shape.height = 80
		
		
	

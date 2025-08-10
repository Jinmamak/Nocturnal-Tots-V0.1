extends StaticBody2D

@onready var blue_sprite: AnimatedSprite2D = $blue_sprite
@onready var blue_collider_top: CollisionShape2D = $blue_collider_top



var OnButton := false



	

func _physics_process(delta: float) -> void:
	if OnButton:
		blue_sprite.play("down")
		blue_collider_top.position.y = -93
		blue_collider_top.shape.radius = 10
		blue_collider_top.shape.height = 120
		
		


func _on_blue_checker_body_entered(body: Node2D) -> void:
	OnButton = true


func _on_blue_checker_body_exited(body: Node2D) -> void:
	pass # Replace with function body.

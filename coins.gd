extends Area2D

var coins = 0


func _on_body_entered(body: Node2D) -> void:
	coins = coins + 1
	print(coins)
	queue_free()

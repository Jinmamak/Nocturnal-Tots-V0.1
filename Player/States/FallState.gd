extends PlayerState

func EnterState():
	Name = "fall"


func ExitState():
	pass

func Draw():
	pass


func Update(delta: float):
	Player.HandleGravity(delta, Player.GravityFall)
	Player.HorizontalMovement()
	Player.HandleLanding()
	Player.HandleJump()
	Player.HandleJumpBuffer()
	HandleAnimations()
	
func HandleAnimations():
	Player.sprite.play("fall")
	Player.HandleFlipH()
	

extends PlayerState

func EnterState():
	Name= "Run"


func ExitState():
	pass

func Update(delta: float):
	#Handle movements
	Player.HorizontalMovement()
	Player.HandleJump()
	Player.HandleFalling()
	HandleAnimations()
	HandleIdle()	
	
func HandleIdle():
	if (Player.moveDirectionX ==0):
		Player.ChangeState(States.idle)

func HandleAnimations():
	Player.sprite.play("run")
	Player.HandleFlipH()

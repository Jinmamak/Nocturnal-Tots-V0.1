extends CharacterBody2D

#region Player Variables

# Nodes
@onready var sprite: AnimatedSprite2D = $Sprite

@onready var collider: CollisionShape2D = $Collider
@onready var States: Node = $StateMachine

@onready var camera: Camera2D = $Camera
@onready var jump_buffer: Timer = $Timers/JumpBufferTimer
@onready var coyote_timer: Timer = $Timers/CoyoteTimer

#Physics variables
const RunSpeed = 1300
const Acceleration = 30
const Deceleration = 50
const GravityJump = 4500                  # Increased for a faster ascent
const GravityFall = 5500                  # Decreased for a gentler fast-fall
const MaxFallVelocity = 4000              # This should still be fine
const JumpVelocity = -2200  
const VariableJumpMultiplier = 0.5
const MaxJumps = 1
const JumpBufferTime = 0.1 # 6 frames
const CoyoteTime = 0.1 # 6 Frames

var moveSpeed = RunSpeed
var jumpSpeed = JumpVelocity
var moveDirectionX = 0
var jumps = 0
var facing = 1

#Input Variables
var keyUp = false
var keyDown = false
var keyLeft = false
var keyRight = false
var keyJump = false
var keyJumpPressed = false

#State Machine
var currentState = null
var prevState = null
#endregion

#region Main Loop Functions
func _ready():
	#Initialize state machine
	for state in States.get_children():
		state.States = States 
		state.Player = self 
	prevState = States.fall
	currentState = States.fall
	

func _draw() -> void:
	currentState.Draw()
	
	
	
func _physics_process(delta: float) -> void:
	# Get Input States
	GetInputStates()
	
	#Update Current State
	currentState.Update(delta)
	
	#Handle Movements
	HandleMaxFallVelocity()
	HandleJump()
	HorizontalMovement()
	
	#Commit Movement
	move_and_slide()
	
	
	
	
func ChangeState(newState): 
	if (newState != null):
		prevState = currentState
		currentState = newState
		prevState.ExitState()
		currentState.EnterState()
		return
#endregion

#region Custom Functions

func GetInputStates():
	
	keyUp = Input.is_action_just_pressed("up")
	keyDown = Input.is_action_just_pressed("down")
	keyLeft = Input.is_action_just_pressed("left")
	keyRight = Input.is_action_just_pressed("right")
	keyJump = Input.is_action_pressed("jump")
	keyJumpPressed = Input.is_action_just_pressed("jump")
	
	if (keyRight): facing = 1
	if (keyLeft): facing = -1
	


func HorizontalMovement(acceleration: float = Acceleration, deceleration: float = Deceleration):
	moveDirectionX = Input.get_axis("left","right")
	if (moveDirectionX != 0):
		velocity.x = move_toward(velocity.x, moveDirectionX * moveSpeed, Acceleration)
	else:
		velocity.x = move_toward(velocity.x, moveDirectionX * moveSpeed, Deceleration)
	
func HandleFalling():
	
	#See if we walked off a ledge if so go to fall state
	if (!is_on_floor()):
		#Start Coyote Timer
		coyote_timer.start(CoyoteTime)
		ChangeState(States.fall)

func HandleJumpBuffer():
	if (keyJumpPressed):
		jump_buffer.start(JumpBufferTime)
		
		
		
func HandleMaxFallVelocity():
	if (velocity.y > MaxFallVelocity): velocity.y = MaxFallVelocity
	
func HandleLanding():
	if (is_on_floor()):
		jumps = 0
		ChangeState(States.idle)
	
		

func HandleGravity(delta, gravity: float = GravityJump):
	if (!is_on_floor()):
		velocity.y += gravity * delta

		
func HandleJump():
	if (is_on_floor()):
		if (jumps < MaxJumps):
			if (keyJumpPressed or jump_buffer.time_left > 0):
				jump_buffer.stop()
				jumps +=1
				ChangeState(States.jump)
	else:
		# Handle Air Jump if Max Jump > 1 (first jump has to be from grnd)
		if ((jumps < MaxJumps) and (jumps > 0) and keyJumpPressed):
			jumps += 1
			ChangeState(States.jump)
			
			
		#Handle Coyote Time Jumps
		if (coyote_timer.time_left > 0):
			if ((keyJumpPressed) and (jumps < MaxJumps)):
				jumps+=1
				ChangeState(States.jump)
			
		
func HandleFlipH():
	sprite.flip_h = (facing < 1)
	
	
#endregion

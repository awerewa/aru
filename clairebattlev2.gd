extends CharacterBody2D

# declare variable for where the player currently is, starts in the middle idle
# options are "idle", "block", "dodgeup", "dodgedown", "dodgeback", and "attack"

@onready var currentaction: String = "idle"

# parameters/Idle/blend_position or whatever the fuck that means

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _process(delta):
	if Input.is_anything_pressed() == true and currentaction == "idle":
		if Input.is_action_just_pressed("attack"):
			currentaction = "attack"
			global_position = Vector2(208,88)
			print("now attacking")
			await get_tree().create_timer(0.2).timeout # wait for 0.2 second
		elif Input.is_action_just_pressed("up"):
			currentaction = "dodgeup"
			global_position = Vector2(220,64)
			print("moved up")
			await Input.is_action_just_released("up") # wait until release button
			
			### FIX FIX FIX FIX!! BUTTONS DONT WORK IF YOURE HOLDING ONE!!!
			### BAD FOR RHYTHM GAMES! BAD FOR MOVEMENT!
			### it makes it feel like it gets stuck
			
		elif Input.is_action_just_pressed("down"):
			currentaction = "dodgedown"
			global_position = Vector2(284,116)
			print("moved down")
			await Input.is_action_just_released("down")
		elif Input.is_action_just_pressed("right"):
			currentaction = "dodgeback"
			global_position = Vector2(304,88)
			print("moved back")
			await Input.is_action_just_released("right")
		elif Input.is_action_just_pressed("left"):
			currentaction = "block"
			global_position = Vector2(208,88)
			print("now blocking")
			await Input.is_action_just_released("left")
	if currentaction != "idle":
		currentaction = "idle"
		global_position = Vector2(248,88)
		print("Finished action, returning to idle")

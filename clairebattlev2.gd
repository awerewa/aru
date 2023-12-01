	extends CharacterBody2D

	# declare variable for where the player currently is, starts in the middle idle
	# options are "idle", "block", "dodgeup", "dodgedown", "dodgeback", and "attack"

	@onready var currentaction: String = "idle"

	# parameters/Idle/blend_position or whatever the fuck that means

	@onready var animation_tree = $AnimationTree
	@onready var state_machine = animation_tree.get("parameters/playback")

	func _process(delta):
		if Input.is_anything_pressed() == true:
			if Input.is_action_just_pressed("attack"):
				currentaction = "attack"
				global_position = Vector2(208,88)
				# print("now attacking")
				await get_tree().create_timer(0.2).timeout # wait for 0.2 second
			elif Input.is_action_just_pressed("up"):
				currentaction = "dodgeup"
				global_position = Vector2(220,64)
				# print("moved up")
			elif Input.is_action_just_pressed("down"):
				currentaction = "dodgedown"
				global_position = Vector2(284,116)
				# print("moved down")
			elif Input.is_action_just_pressed("right"):
				currentaction = "dodgeback"
				global_position = Vector2(304,88)
				# print("moved back")
			elif Input.is_action_just_pressed("left"):
				currentaction = "block"
				global_position = Vector2(208,88)
				# print("now blocking")
		if currentaction != "idle" and not Input.is_action_pressed("up") and not Input.is_action_pressed("down") and not Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
			currentaction = "idle" # the code above makes sure you're not pressing anything before returning to idle
			global_position = Vector2(248,88)
			# print("Finished action, returning to idle")

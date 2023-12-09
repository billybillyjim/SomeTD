extends AnimatedSprite2D

var prev_position : Vector2

func _process(delta):
	var move_dir = self.global_position - prev_position

	var angle = move_dir.angle()
	var angle_degrees = rad_to_deg(angle)
	var animation_name = ""

	if -45 <= angle_degrees and angle_degrees < 45:
		animation_name = "walk_east"
	elif 45 <= angle_degrees and angle_degrees < 135:
		animation_name = "walk_south"
	elif -135 <= angle_degrees and angle_degrees < -45:
		animation_name = "walk_north"
	else:
		animation_name = "walk_west"
		
	self.play(animation_name)
	
	prev_position = self.global_position
	

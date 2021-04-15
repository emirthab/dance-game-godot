extends Spatial


var min_timer = 0.4
var max_velocity = 2

#0.6
#1.8
var mistake
var start_velocity = 1

var delta_velocity = 0.02
var delta_timer = 0.017

var current_velocity

var keys = []
var keyobjects = []

var score = 0
var stop

var dance
var music

func _ready():
	stop = true
	mistake = 0
	current_velocity = start_velocity

func loadchar():
	var mus = load(str("res://assets/sounds/",music))
	mus.set_loop(false)
	$AudioStreamPlayer.stream = mus
	$AudioStreamPlayer.play()
	stop = false
	var character = load(str("res://assets/character/",dance)).instance()
	character.set_name("balici")
	add_child(character)
	character.global_transform = $character.global_transform
	var anim = $balici/AnimationPlayer.get_animation("ArmaturemixamocomLayer0")
	anim.set_loop(true)
	$balici/AnimationPlayer.play("ArmaturemixamocomLayer0")
	
func _process(delta):
	$score.text = str(score)
	if mistake > 2 && !stop:
		var slide = preload("res://assets/character/slide.glb").instance()
		slide.global_transform = $balici.global_transform
		slide.set_name("slide")
		add_child(slide)
		slide.rotation.y = 90
		$balici.queue_free()
		$slide/AnimationPlayer.play("ArmaturemixamocomLayer0")
		var yarra = preload("res://assets/sounds/yarra.ogg")
		yarra.set_loop(false)
		$AudioStreamPlayer.stream = yarra
		$AudioStreamPlayer.play()
		stop = true
		mistake = 0
	
	#DEBUG
	#var text = ""
	#for i in keys.size():
	#	text += (str(keys[i],"\n"))
	#$score.text = text


func _input(event):
	var just_pressed = event.is_pressed() and not event.is_echo()
	if Input.is_key_pressed(KEY_A) and just_pressed && !stop:
		if keys.size() >0:
			if keys[0] == "a":
				mistake = 0
				score += current_velocity * 100
				create_effect(true)
			else:
				mistake += 1
				create_effect(false)
			keys.remove(0)
			if $Spawn.get_child_count() >0:
				$Spawn.get_child(0).queue_free()
			
	elif Input.is_key_pressed(KEY_S) and just_pressed && !stop:
		if keys.size() >0:
			if keys[0] == "s":
				mistake = 0
				score += current_velocity * 100
				create_effect(true)
			else:
				mistake += 1
				create_effect(false)
			keys.remove(0)
			if $Spawn.get_child_count() >0:
				$Spawn.get_child(0).queue_free()
	elif Input.is_key_pressed(KEY_D) and just_pressed && !stop:
		if keys.size() >0:
			if keys[0] == "d":
				mistake = 0
				score += current_velocity * 100
				create_effect(true)
			else:
				mistake += 1
				create_effect(false)
			keys.remove(0)
			if $Spawn.get_child_count() >0:
				$Spawn.get_child(0).queue_free()
	elif Input.is_key_pressed(KEY_W) and just_pressed && !stop:
		if keys.size() >0:
			if keys[0] == "w":
				mistake = 0
				score += current_velocity * 100
				create_effect(true)
			else:
				mistake += 1
				create_effect(false)
			keys.remove(0)
			if $Spawn.get_child_count() >0:
				$Spawn.get_child(0).queue_free()

func _on_Timer_timeout():
	var ins
	var rand = randi() % 4 + 1
	match rand:
		1:
			keys.append("a")
			ins = preload(str("res://assets/keys/a.tscn")).instance()
		2:
			keys.append("s")
			ins = preload(str("res://assets/keys/s.tscn")).instance()
		3:
			keys.append("d")
			ins = preload(str("res://assets/keys/d.tscn")).instance()
		4:
			keys.append("w")
			ins = preload(str("res://assets/keys/w.tscn")).instance()
			
	if $Timer.wait_time > min_timer && !stop:
		$Timer.wait_time -= delta_timer
		
	if current_velocity < max_velocity && !stop:
		current_velocity += delta_velocity
	if !stop:
		ins.linear_velocity.y = current_velocity
		$Spawn.add_child(ins)
		
	
func _on_area_body_entered(body):
	keys.remove(0)
	body.queue_free()
	create_effect(false)
	mistake += 1
	
func create_effect(boolean):
	var xyz = $Spawn.get_child(0).global_transform
	if boolean == false && !stop:
		var false_effect = preload("res://assets/false_effect.tscn").instance()
		false_effect.global_transform = xyz
		false_effect.emitting = true
		add_child(false_effect)
	elif !stop:
		var true_effect = preload("res://assets/true_effect.tscn").instance()
		true_effect.global_transform = xyz
		true_effect.emitting = true
		add_child(true_effect)


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")

extends PanelContainer


func _ready():
	pass


func _on_tirrek_pressed():
	hide()
	print("deneme")
	var scene = preload("res://scenes/game.tscn").instance()
	add_child(scene)
	$game.dance = "hiphop.tscn"
	$game.music = "olta_remix.ogg"
	$game.loadchar()
	$Sprite.queue_free()


func _on_tirrek2_pressed():
	hide()
	var scene = preload("res://scenes/game.tscn").instance()
	add_child(scene)
	$game.dance = "tirrek.tscn"
	$game.music = "abe_kaynana.ogg"
	$game.loadchar()
	$Sprite.queue_free()


func _on_tirrek3_pressed():
	hide()
	var scene = preload("res://scenes/game.tscn").instance()
	add_child(scene)
	$game.dance = "samba.glb"
	$game.music = "ask_benimle.ogg"
	$game.loadchar()
	$Sprite.queue_free()

extends KinematicBody2D

export(String) var item_type = 'sword'
var my_texture
var metadata = {}

func _ready():
	# icone do item
	var item_icon = load("res://sprites/{type}.png".format({"type": item_type}))
	
	# Identificadores dos itens
	metadata['type'] = item_type
	metadata['name'] = item_type
	metadata['icon'] = item_icon
	
	$sprite.set_texture(item_icon)

func _on_hitbox_body_entered(body):
	if body.is_in_group("hero"):
		var hero  = body
		
		var item = self.duplicate()
		metadata["item"] = item
		
		Inventory.add_item(hero, metadata)
				
		self.queue_free()

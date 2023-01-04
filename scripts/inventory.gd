extends Node

var items = {}
var displayList:ItemList;

func setDisplayList(list):
	self.displayList = list

func add_item(owner, item):
	var id = items.size()
	items[id] = item
	items[id].owner = owner
	
	displayList.add_item(
		item['name'], 
		item['icon'], 
		true
	)
		
	return id

func has_item( type ):
	for id in items:
		if items[id].type == type:
			return true
			
	return false 
		

func remove_item(id):
	# Devolve o item ao cenário
	restore_item(id)
	# remove o item da memora
	items.erase(id)

func restore_item(id):
	var hero = items[id].owner
	var item = items[id].item
	hero.get_parent().add_child(item)
	item.position = Vector2( (hero.position.x - 50), (hero.position.y + 50) )
	
func remove_first():
	var keys = items.keys()
	if keys.size() > 0:
		var id = keys[0]
		displayList.remove_item(0)
		remove_item(id)


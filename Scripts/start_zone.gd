extends Node2D
var scene
var scene_name
var scene_file

# Called when the node enters the scene tree for the first time.
func _ready():
	scene_name = "start_zone_map"


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _change_scene(_scene_name):
	scene = load(_scene_name).instantiate()
	add_child(scene)


func _on_transition_anim_ready(_area_file, _area_name):
	remove_child(get_node(scene_name))
	scene_name = _area_name
	scene_file = _area_file
	_change_scene(scene_file)

extends Node2D
var scene
var scene_name
var killnode
var scene_file
signal child_alive
# Called when the node enters the scene tree for the first time.
func _ready():
	scene_name = "start_zone_map"

func _change_scene(_scene_file):
	get_node("$" + scene_name).queue_free()
	scene = load(_scene_file).instantiate()
	add_child(scene)
	emit_signal("child_alive", scene_name)


func _on_transition_anim_ready(_area_file, _area_name):
	remove_child(get_node(scene_name))
	scene_name = _area_name
	scene_file = _area_file
	_change_scene(scene_file)

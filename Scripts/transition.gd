extends Control

class_name Transition
var area_name
var area_file
var tp_x
var tp_y
var current_door1
var current_door2
var current_door3
signal anim_ready
signal char_move
@export var scene_switch_anim : String = "fade_out"

@onready var animation_tex : TextureRect = $TextureRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tex.visible = false;

func animation_warp(_anim_file, _anim_name):
		area_name = _anim_name
		area_file = _anim_file
		animation_player.queue("fade_out")

func _on_animation_player_animation_finished(anim_name):
	if(anim_name == scene_switch_anim):
		animation_player.queue("fade_in")
		emit_signal("anim_ready", area_file, area_name)
		emit_signal("char_move", tp_x, tp_y)


func _on_cavedoor_body_entered(body):
	if body.is_in_group("player"):
		tp_x = 75
		tp_y = 16
		animation_warp("res://Scenes/cave_zone.tscn", "cave_zone")

func _on_cavedoor_out_body_entered(body):
	if body.is_in_group("player"):
		tp_x = 88
		tp_y = 72
		animation_warp("res://Scenes/start_zone_map.tscn", "start_zone_map")


func _on_start_zone_child_alive(zonename):
	if(zonename == "cave_zone"):
		current_door1 = get_tree().get_root().get_node("start_zone/cave_zone/cavedoor_out")
		current_door1.body_entered.connect(self._on_cavedoor_out_body_entered)

extends Control

class_name Transition
var area_name
var area_file
signal anim_ready
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


func _on_cavedoor_body_entered(body):
	if body.is_in_group("player"):
		animation_warp("res://Scenes/cave_zone.tscn", "cave_zone")

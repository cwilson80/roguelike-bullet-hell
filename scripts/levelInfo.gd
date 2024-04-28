extends Node

var level = 1
var current_scene = null
var score = 0
var player_speed
var fire_rate = 0.8
var health = 2
var score_multiplier = 1

# These are for the shop
var fire_rate_cost = 500
var health_cost = 1000
var score_mult_cost = 2000

var fire_rate_count = 0
var health_count = 0
var score_mult_count = 0

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

#---------------------------------------------------------------------!
#Check https://docs.godotengine.org/en/latest/tutorials/scripting/singletons_autoload.html
#For info on singletons

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene

#---------------------------------------------------------------------!
func next_level():
	level += 1
	get_node("/root/Main/LevelTimer").start() # Restarts the level timer

func get_level():
	return level




extends Area2D

var main_scene
var main_instance
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#main_scene = ResourceLoader.load("res://main.tscn")
	#main_instance = main_scene.instantiate()
	#need to connect signals
	#main_instance.connect("do_save", self, "_on_main_signal_received")
	#main_instance.connect("do_load", self, "_on_main_signal_received")
	
func _on_main_signal_received():
	print("yes?")


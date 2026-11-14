extends Node2D

const turned = preload("res://Sonion/SonionRingBackTurned.png")
const watching = preload("res://Sonion/SonionRingFaceTurned.png")
const warning = preload("res://Sonion/SonionRingWarning.png")

var timer: float = randf_range(3, 8)
var triggered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()
	$Warning.visible = false
	$Warning.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	if (timer < 0):
		trigger()
	elif (timer < 1):
		warn()

func reset():
	triggered = false
	$Child.texture = turned

func warn():
	$Warning.visible = true
	$Child.texture = warning

func trigger():
	triggered = true
	$Warning.visible = false
	get_tree().create_timer(5).timeout.connect(reset)
	timer = randf_range(6, 9)
	$Child.texture = watching
	

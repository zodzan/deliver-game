extends Node

class_name State

signal state_finished(state_key)

var state_machine: WeakRef
var actor: WeakRef
var key: String

func _ready() -> void:
    state_machine = weakref(get_parent())

func set_actor(actor_reference: WeakRef) -> void:
    actor = actor_reference

func set_key(state_key: String) -> void:
    key = state_key

func start() -> void:
    pass

func stop() -> void:
    pass

func action(delta: float) -> void:
    pass

func _on_animation_finished(animation_name: String) -> void:
    pass

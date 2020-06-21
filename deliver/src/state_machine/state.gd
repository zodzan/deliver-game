extends Node

class_name State

signal state_done(next_state_key)

var state_machine: WeakRef
var actor: WeakRef

func _ready() -> void:
    state_machine = weakref(get_parent())

func set_actor(actor_reference: WeakRef) -> void:
    actor = actor_reference

func start() -> void:
    pass

func stop() -> void:
    pass

func action(delta: float) -> void:
    pass

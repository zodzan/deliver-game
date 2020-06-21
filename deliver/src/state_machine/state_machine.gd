extends Node

class_name StateMachine

var states: Dictionary
var state: State

func update(delta: float) -> void:
    if is_instance_valid(state):
        state.action(delta)

func add_state(new_key: String, new_state: State, actor_reference: WeakRef) -> void:
    if !states.has(new_key):
        new_state.set_key(new_key)
        new_state.set_actor(actor_reference)
        states[new_key] = new_state

func set_state(next_state_key: String) -> void:
    var next_state: State
    
    if states.has(next_state_key):
        next_state = states[next_state_key]
        _swap_state(next_state)
        
func _swap_state(next_state: State) -> void:
    if is_instance_valid(next_state):
        if is_instance_valid(state):
            state.stop()
        
        state = next_state
        state.start()

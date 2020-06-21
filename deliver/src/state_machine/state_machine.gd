extends Node

class_name StateMachine

const STATE_DONE_METHOD: String = "_on_state_done"

var signal_methods: Dictionary = {
    "state_done": STATE_DONE_METHOD
}

var states: Dictionary
var state_key: String
var state: State

func update(delta: float) -> void:
    if is_instance_valid(state):
        state.action(delta)

func add_state(new_key: String, new_state: State) -> void:
    if !states.has(new_key):
        states[new_key] = new_state

func set_state(next_state_key: String) -> void:
    var next_state: State
    
    if states.has(next_state_key):
        next_state = states[next_state_key]
        _swap_state(next_state_key, next_state)
        
func _swap_state(next_state_key: String, next_state: State) -> void:
    if is_instance_valid(next_state):
        if is_instance_valid(state):
            state.stop()
        
        state = next_state
        state_key = next_state_key
        state.start()

func _on_state_done(next_state_key: String) -> void:
    set_state(next_state_key)

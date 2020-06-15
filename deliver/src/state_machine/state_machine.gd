extends Node

class_name StateMachine

const STATE_DONE_METHOD: String = "_on_state_done"
const STATE_DONE_WARNING: String = "initialize_state(): signal state_done not connected."

var signal_methods: Dictionary = {
    State.STATE_DONE_SIGNAL: STATE_DONE_METHOD
}

var states: Dictionary
var state_idx: int
var state: State

func update(delta: float) -> void:
    if is_instance_valid(state):
        state.action(delta)

func initialize_state(idx: int, new_state: State) -> void:
    var key: String = _key_map(idx)
    
    if !key.empty() and !is_instance_valid(states[key]):
        states[key] = new_state
        
        if !new_state.is_connected(
            State.STATE_DONE_SIGNAL, 
            self, 
            signal_methods[State.STATE_DONE_SIGNAL]
        ):
            print(STATE_DONE_WARNING)
            var _connect := new_state.connect(
                State.STATE_DONE_SIGNAL, 
                self, 
                signal_methods[State.STATE_DONE_SIGNAL]
            )

func set_state(next_state_idx: int) -> void:
    var key: String = _key_map(next_state_idx)
    var next_state: State
    
    if !key.empty():
        next_state = states[key]
        _swap_state(next_state, next_state_idx)
        
func _swap_state(next_state: State, next_state_idx: int) -> void:
    if is_instance_valid(next_state):
        if is_instance_valid(state):
            state.stop()
        
        state = next_state
        state_idx = next_state_idx
        state.start()

func _on_state_done(next_state_idx: int) -> void:
    set_state(next_state_idx)

func _key_map(idx: int) -> String:
    return String()

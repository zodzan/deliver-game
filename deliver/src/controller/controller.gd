extends Node

class_name Controller

enum SLOT_WISH {NONE, SLOT_1, SLOT_2, SLOT_3}

var direction_input: Vector2
var mouse_motion_input: Vector2

var fire_input: bool
var alt_fire_input: bool
var use_input: bool
var jump_input: bool
var slot_input: int

func process_direction_input() -> void:
    direction_input = Vector2.ZERO
    
    if Input.is_action_pressed("move_forward"):
        direction_input.y += 1
    if Input.is_action_pressed("move_back"):
        direction_input.y -= 1
    if Input.is_action_pressed("move_right"):
        direction_input.x += 1
    if Input.is_action_pressed("move_left"):
        direction_input.x -= 1

    direction_input = direction_input.normalized()

func process_mouse_motion_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        mouse_motion_input -= event.relative * Settings.m_sensitivity

func fire_wish(event: InputEvent) -> bool:
    fire_input = event.is_action_pressed("fire")
    return fire_input

func alt_fire_wish(event: InputEvent) -> bool:
    alt_fire_input = event.is_action_pressed("alt_fire")
    return alt_fire_input

func use_wish(event: InputEvent) -> bool:
    use_input = event.is_action_pressed("use")
    return use_input

func jump_wish(event: InputEvent) -> bool:
    jump_input = event.is_action_pressed("jump")
    return jump_input

func slot_wish(event: InputEvent) -> int:
    slot_input = SLOT_WISH.NONE
    
    if event.is_action_pressed("slot_1"): 
        slot_input = SLOT_WISH.SLOT_1
    elif event.is_action_pressed("slot_2"):
        slot_input = SLOT_WISH.SLOT_2
    elif event.is_action_pressed("slot_3"):
        slot_input = SLOT_WISH.SLOT_3
    
    return slot_input

func set_mouse_captured(enable: bool):
    if enable: 
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    else:
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

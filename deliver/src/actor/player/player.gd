extends Actor

class_name Player

var controller: Controller

func _ready() -> void:
    controller = $Controller
    
    set_process_unhandled_input(true)
    set_physics_process(true)

func _unhandled_input(event: InputEvent) -> void:
    controller.process_mouse_motion_input(event)
    
    if controller.jump_wish(event):
        print("INPUT: jump")
    
    if controller.fire_wish(event):
        print("INPUT: fire")
    elif controller.alt_fire_wish(event):
        print("INPUT: alt_fire")

    if controller.use_wish(event):
        print("INPUT: use")
        
    var slot_wish: int = controller.slot_wish(event)
    if slot_wish != controller.SLOT_WISH.NONE:
        print("INPUT: slot_", slot_wish)

func _physics_process(delta: float) -> void:
    controller.process_direction_input()

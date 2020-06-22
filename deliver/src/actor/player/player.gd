extends Actor

class_name Player

const PITCH_ANGLE_EPSILON = 0.05
const MAX_PITCH_ANGLE = 90.0
const MIN_PITCH_ANGLE = -90.0

const GRAVITY = 19.0
const MAX_MOVE_SPEED = 15.0
const JUMP_SPEED = 10.0
const ACCELERATION = 6.0
const FRICTION = 6.0

var controller: Controller

var camera_holder: Spatial
var camera: Camera

var yaw: float
var pitch: float

func _ready() -> void:
    controller = $Controller
    camera_holder = $CameraHolder
    camera = $CameraHolder/Camera
    
    controller.set_mouse_captured(true)
    set_process_unhandled_input(true)
    set_physics_process(true)

func _unhandled_input(event: InputEvent) -> void:
    controller.process_mouse_motion_input(event)
    
    if controller.jump_wish(event):
        process_jump()
    
    if controller.fire_wish(event):
        process_fire()
    elif controller.alt_fire_wish(event):
        process_alt_fire()

    if controller.use_wish(event):
        process_use()
        
    var slot_wish: int = controller.slot_wish(event)
    if slot_wish != controller.SLOT_WISH.NONE:
        process_slot_swap(slot_wish)
        
    if event.is_action_pressed("ui_cancel"):
        if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
            controller.set_mouse_captured(false)
        elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
            controller.set_mouse_captured(true)

func _physics_process(delta: float) -> void:
    controller.process_direction_input()
    process_direction()
    process_movement(delta)
    process_rotation(delta)
    
    transform = transform.orthonormalized()

func process_direction() -> void:
    var camera_transform: Transform = camera.get_global_transform()
    
    direction = Vector3.ZERO
    direction += camera_transform.basis.z * controller.direction_input.y * -1
    direction += camera_transform.basis.x * controller.direction_input.x

func process_movement(delta: float) -> void:
    var h_direction: Vector3 = Vector3(direction.x, 0, direction.z)
    var h_velocity: Vector3 = Vector3(velocity.x, 0, velocity.z)
    var target_velocity: Vector3
    var acceleration: float
    
    h_direction = h_direction.normalized()
    target_velocity = h_direction * MAX_MOVE_SPEED
    
    if h_direction.dot(h_velocity) > 0:
        acceleration = ACCELERATION
    else:
        acceleration = FRICTION
        
    h_velocity = h_velocity.linear_interpolate(target_velocity, acceleration * delta)
    velocity.x = h_velocity.x
    velocity.y -= GRAVITY * delta
    velocity.z = h_velocity.z
    velocity = move_and_slide(velocity, Vector3.UP)

func process_rotation(delta: float) -> void:
    var rot_x: float
   
    yaw = controller.mouse_motion_input.x
    pitch = controller.mouse_motion_input.y 
    
    rotate_y(deg2rad(yaw * delta))
    camera_holder.rotate_x(deg2rad(pitch * delta))
    
    rot_x = clamp(
        camera_holder.rotation_degrees.x,
        MIN_PITCH_ANGLE + PITCH_ANGLE_EPSILON,
        MAX_PITCH_ANGLE - PITCH_ANGLE_EPSILON
    )
    camera_holder.rotation_degrees.x = rot_x
    
    controller.mouse_motion_input = Vector2.ZERO
    
func process_jump() -> void:
    if is_on_floor():
        velocity.y += JUMP_SPEED

func process_use() -> void:
    print("INPUT: use")
    
func process_fire() -> void:
    print("INPUT: fire")
    
func process_alt_fire() -> void:
    print("INPUT: alt_fire")

func process_slot_swap(slot_wish: int) -> void:
    print("INPUT: slot_", slot_wish)

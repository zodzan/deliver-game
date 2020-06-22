extends KinematicBody

class_name Actor

var direction: Vector3
var velocity: Vector3

# warning-ignore:unused_argument
func receive_health(heal: float) -> void:
    pass

# warning-ignore:unused_argument
func receive_damage(damage: float) -> void:
    pass

# warning-ignore:unused_argument
func receive_impulse(impulse: Vector3) -> void:
    pass

extends KinematicBody

class_name Actor

func process_movement() -> void:
    pass

func process_rotation(delta: float) -> void:
    pass

func process_direction() -> void:
    pass

func receive_heal(health_value: float) -> void:
    pass

func receive_damage(damage_value: float) -> void:
    pass

func receive_impulse(impulse: Vector3) -> void:
    pass

func scan(from: Vector3, to: Vector3) -> Dictionary:
    return WorldUtils.raycast_query(
        self, 
        from, 
        to, 
        collision_mask
    )

func in_sight_of(target: Spatial) -> bool:
    var position: Vector3 = global_transform.origin
    var target_position: Vector3 = target.global_transform.origin
    
    var sight_collision: Dictionary = scan(
            position, 
            target_position
    )
    
    return sight_collision and sight_collision.collider == target

extends Node

static func raycast_query(
    entity: Spatial,
    from: Vector3, 
    to: Vector3, 
    collision_mask: int
    ) -> Dictionary:
    var space_state := entity.get_world().direct_space_state
    return space_state.intersect_ray(from, to, [], collision_mask)

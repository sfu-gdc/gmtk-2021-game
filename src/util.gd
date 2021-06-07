# gets a uniform random item in the list.
static func random_in(list, rand):
	return list[rand.randi_range(0, len(list)-1)]

static func static_rect_body(size):
	var shape = RectangleShape2D.new()
	shape.extents = size / 2

	var collider = CollisionShape2D.new()
	collider.set_shape(shape)

	var body = StaticBody2D.new()
	body.add_child(collider)

	return body
	
static func circle_collider(radius):
	var shape = CircleShape2D.new()
	shape.radius = radius

	var collider = CollisionShape2D.new()
	collider.set_shape(shape)

	return collider

static func vec_round(vec):
	return Vector2(round(vec.x), round(vec.y))

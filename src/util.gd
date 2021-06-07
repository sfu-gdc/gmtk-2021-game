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

# for when treating a list as a matrix
static func mat2_get(mat_list, width, vec2):
	return mat_list[vec2.x + width * vec2.y]
static func mat2_set(mat_list, width, vec2, val):
	mat_list[vec2.x + width * vec2.y] = val

# inits a list to val.
static func list_comprehension(list1, list2, val):
	for x in list2:
		list1.append(val)
	return list1

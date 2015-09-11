extends Spatial

var cam = null
var camZ = 0.0

var sewer_segment = preload('res://partials/sewer1.xscn')
var sewer_length = 6.0
var num_segments = 5
var segment_index = 0

func _ready():
	cam = get_node("Camera")
	
	for i in range(num_segments):
		var segment_instance = sewer_segment.instance()
		segment_instance.set_name("segment"+str(i))
		segment_instance.set_translation(Vector3(0.0, 0.0, -i * sewer_length))
		add_child(segment_instance)
		
	set_process(true)
	pass

func _process(delta):
	var offset = -1 * delta
	camZ += offset
	cam.translate(Vector3(0.0,0.0,offset))
	
	var cur_segment = int(-camZ / sewer_length)	
	if cur_segment > segment_index:
		print("Adding sewer element "+ str(cur_segment))
		print("Camera now at " + str(camZ))
		add_sewer_segment()
		remove_first_sewer_segment()

func add_sewer_segment():
	var new_segment_index = segment_index + num_segments
	var segment_instance = sewer_segment.instance()
	segment_instance.set_name("segment"+str(new_segment_index))
	segment_instance.set_translation(Vector3(0.0, 0.0, -new_segment_index * sewer_length))
	add_child(segment_instance)
	segment_index += 1
	
func remove_first_sewer_segment():
	var segment = get_node("segment"+str(segment_index - num_segments))
	if segment != null:
		print("removing")
		segment.queue_free()
		#remove_child(segment)
		print("Elements left: " + str(get_child_count()))
	else:
		print("nope")
@tool
extends Node3D

@onready var lod_0: MeshInstance3D
@onready var lod_1: MeshInstance3D
@onready var lod_2: MeshInstance3D
@onready var lod_3: MeshInstance3D
@export_range(0.0, 2000.0, 5) var LOD_bias := 3.0
@export_category("LOD settings")
@export_range(0.0, 10.0, 1) var LOD0_dist := 3.0
@export_range(0.0, 10.0, 1) var LOD1_dist := 1.0
@export_range(0.0, 10.0, 1) var LOD2_dist := 1.0
@export_range(0.0, 10.0, 1) var LOD3_dist := 2.0
@export_flags("still") var last_lod = 1

func _process(delta: float):
	update_lods(LOD_bias)

func update_lods(value):
	var lod_num = get_child_count()
	# lod pathes
	if lod_num == 1:
		push_error("lods must be between 2-4")
	if lod_num == 2:
		lod_0 = $LOD0
		lod_1 = $LOD1
	if lod_num == 3:
		lod_0 = $LOD0
		lod_1 = $LOD1
		lod_2 = $LOD2
	if lod_num == 4:
		lod_0 = $LOD0
		lod_1 = $LOD1
		lod_2 = $LOD2
		lod_3 = $LOD3
	if lod_num > 4:
		push_error("lods must be between 2-4")
		# vis values

	if lod_num > 1:
		lod_0.visibility_range_begin = 0
		lod_0.visibility_range_end = LOD0_dist * value
		lod_1.visibility_range_begin = lod_0.visibility_range_end
		if lod_num == 2:
			if last_lod == 1:
				lod_1.visibility_range_end = 0
			if last_lod == 0:
				lod_1.visibility_range_end = LOD1_dist + lod_1.visibility_range_begin * value
	if lod_num > 2:
		lod_1.visibility_range_end = LOD1_dist + lod_1.visibility_range_begin * value
		lod_2.visibility_range_begin = lod_1.visibility_range_end
		if lod_num == 3:
			if last_lod == 1:
				lod_2.visibility_range_end = 0
			if last_lod == 0:
				lod_2.visibility_range_end = LOD2_dist + lod_2.visibility_range_begin * value
	if lod_num > 3:
		lod_2.visibility_range_end = LOD2_dist + lod_2.visibility_range_begin * value
		lod_3.visibility_range_begin = lod_2.visibility_range_end
		if lod_num == 4:
			if last_lod == 1:
				lod_3.visibility_range_end = 0
			if last_lod == 0:
				lod_3.visibility_range_end = LOD3_dist + lod_3.visibility_range_begin * value

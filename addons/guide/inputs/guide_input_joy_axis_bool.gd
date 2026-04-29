## Input from a single joy axis.
@tool
class_name GUIDEInputJoyAxisBool
extends GUIDEInputJoyBase

## The joy axis to sample
@export var axis:JoyAxis = JOY_AXIS_LEFT_X:
	set(value):
		if value == axis:
			return
		axis = value
		emit_changed()

@export_range(0.01, 0.99, 0.01) var activation_threshold : float = 0.5:
	set(value):
		if value == activation_threshold:
			return
		activation_threshold = value
		emit_changed()


func _begin_usage() -> void:
	_state.joy_axis_state_changed.connect(_refresh)


func _end_usage() -> void:
	_state.joy_axis_state_changed.disconnect(_refresh)


func _refresh() -> void:
	_value.x = 1.0 if _state.get_joy_axis_value(joy_index, axis) > activation_threshold else 0.0


func is_same_as(other:GUIDEInput) -> bool:
	return other is GUIDEInputJoyAxisBool and \
		other.axis == axis and \
		other.joy_index == joy_index


func _to_string() -> String:
	return "(GUIDEInputJoyAxisBool: axis=" + str(axis) + ", joy_index="  + str(joy_index) + ")"


func _editor_name() -> String:
	return "Joy Axis Bool"


func _editor_description() -> String:
	return "The input from a single joy axis as a boolean."


func _native_value_type() -> GUIDEAction.GUIDEActionValueType:
	return GUIDEAction.GUIDEActionValueType.BOOL

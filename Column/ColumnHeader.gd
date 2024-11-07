extends Button

# Signals ..................................
signal COLUMN_SORT(value)

# Enums .....................................
enum SORT_STATE {NULL=-1, DESCEND=0, ASCEND=1}

# ................... Export Shared Variables ..................
@export var index = -1
@export var sortState = SORT_STATE.NULL

# Called when the node enters the scene tree for the first time.
func _ready():
	_ChangeSortState(SORT_STATE.NULL)
	connect("pressed",Callable(self,"_on_Button_pressed"))

func _on_Button_pressed():
	match sortState:
		SORT_STATE.NULL:
			_ChangeSortState(SORT_STATE.ASCEND)
		SORT_STATE.ASCEND: 
			_ChangeSortState(SORT_STATE.DESCEND)
		SORT_STATE.DESCEND: 
			_ChangeSortState(SORT_STATE.ASCEND)
	emit_signal("COLUMN_SORT", self)

func _ChangeSortState(newStatus):
	sortState = newStatus
	if sortState == SORT_STATE.NULL:
		$TextureRect.visible = false
		return
	$TextureRect.visible = true
	if sortState == SORT_STATE.ASCEND:
		$TextureRect.flip_v = false
	else: 
		$TextureRect.flip_v = true	

func _SortStateNULL():
	_ChangeSortState(SORT_STATE.NULL)

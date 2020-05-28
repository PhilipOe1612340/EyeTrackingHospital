extends RichTextLabel

func _on_GlobalState_scoreChanged(score) -> void:
	set_text('Accidents: ' + str(score))

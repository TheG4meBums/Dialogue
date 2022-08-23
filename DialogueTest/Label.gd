extends Label

export var dialogue = ["Why hello there traveller!", "How do you do?"]

var active = false
var clearOnActivate = true
var activeCharIndex
var length
var array
var Char
var hasOption = false
var dialogueState = 0
var lengthAdjusted

export var textSpeed = 0.1

func _ready():
	text = dialogue[0]
	var t = text
	array = []
	for d in t:
		array.append(d)
	Activate()


func Activate():
	$Button.visible = false
	$Good.visible = false
	$Bad.visible = false
	activeCharIndex = 0
	length = get_text().length()
	lengthAdjusted = length - 1
	
	if text == "How do you do?":
		hasOption = true
	
	if clearOnActivate:
		text = ""
		#clearOnActivate = false
		
	if !active:
		ShowDialogue()
		active = true
		
		
func ShowDialogue():
			
	for c in length:
		c = activeCharIndex
		
		if c < length and !null:
			Char = array[c]
			c += 1
			text += Char
			activeCharIndex += 1
			
			if Char == ";":
				active = false
				clearOnActivate = true
				break
				
			if Char == ":":
				clearOnActivate = false
				break
				
			if Char == ".":
				textSpeed = textSpeed * 10
				yield(get_tree().create_timer(textSpeed), "timeout")
				textSpeed = textSpeed / 10
				
			yield(get_tree().create_timer(textSpeed), "timeout")
		
		if c >= length and hasOption:
			$Button.visible = false
			$Good.visible = true
			$Bad.visible = true
			array.clear()
		
		if c >= length and !hasOption:
			$Button.visible = true
				
	active = false


func _on_Button_pressed():
	dialogueState += 1
	var dialogueSize = dialogue.size() - 1
	if dialogueState <= dialogueSize:
		array.clear()
		text = dialogue[dialogueState]
		var t = text
		array = []
		for d in t:
			array.append(d)
		Activate()


func _on_Good_pressed():
	dialogue = ["Oh that's great to hear!", "Hope it stays that way!"]
	dialogueState = 0
	text = dialogue[0]
	for c in text:
		array.append(c)
	Activate()
	hasOption = false
	

func _on_Bad_pressed():
	dialogue = ["Sorry to hear...", "Hope you get better soon"]
	dialogueState = 0
	text = dialogue[0]
	for c in text:
		array.append(c)
	Activate()
	hasOption = false

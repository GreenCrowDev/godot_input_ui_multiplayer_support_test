extends Control

# Steps to reproduce:
# Have at least 2 joypads, or map a device in order to have at least 2 players.
# This scene tests if the system can distinguish between the same action
# pressed by 2 or more different players.
# 1. Press "ui_select" on the 1st device and KEEP IT PRESSED -> the print will execute;
# 2. Press "ui_select" on the 2nd device -> the 2nd print will execute;
# If you see the 2nd "just pressed" print, the test succeded.
# If the 2nd "just pressed" print didn't execute, the test failed.
# The previous behaviour was that the 2nd "just pressed" print should not be
# triggered, since the same action cannot be triggered more than one time.
# You can try this by pressing "ui_select" with the keyboard spacebar,
# keep it pressed, and meanwhile press it on the controller.
# Doing this for the same player will not result in a new "just pressed" trigger,
# and that is the correct behaviour.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select", false, PLAYER_ID_P1):
			print("P1 select just pressed.")
	if Input.is_action_just_released("ui_select", false, PLAYER_ID_P1):
			print("P1 select just released.")
	
	if Input.is_action_just_pressed("ui_select", false, PLAYER_ID_P2):
			print("P2 select just pressed.")
	if Input.is_action_just_released("ui_select", false, PLAYER_ID_P2):
			print("P2 select just released.")

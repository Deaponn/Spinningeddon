extends Control

signal create_client_pressed

func _ready():
	connect("create_client_pressed", LobbyManager, "create_client")

func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/MainMenu/MainMenu.tscn")


func _on_JoinBtn_pressed():
	LobbyManager.my_name = find_node("PlayerName").text
	print("In join name: ")
	LobbyManager.server_ip = find_node("IpAddress").text
	emit_signal("create_client_pressed")

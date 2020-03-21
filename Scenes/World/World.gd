extends Node2D

var Bullet = preload("res://Entities/Bullet/Bullet.tscn")
var BattleRoyaleMap = preload("res://Maps/BattleRoyaleMap.tscn")

var map

func _ready():
	map = BattleRoyaleMap.instance()
	add_child(map)

remotesync func spawn_bullet(player_id):
	var bullet = Bullet.instance()
	var player = get_node(str(player_id))
	bullet.set_name("bullet" + str(GameManager.bullets_count))
	add_child(bullet)
	bullet.global_position = player.get_node("Body/Rifle/Bullet_spawn").global_position
	bullet.init(player.bullet_speed, player.bullet_damage, 
				Vector2(0, -1).rotated(player.get_node("Body").rotation), 
				player.get_node("Body").rotation, player.bullet_range)
	GameManager.bullets_info[bullet.get_name()] = {"position": bullet.global_position, "rotation": bullet.get_node("Sprite").rotation}
	GameManager.bullets_count += 1
	
remotesync func delete_bullet(bullet_name):
	GameManager.bullets_info.erase(bullet_name)
	get_node(bullet_name).queue_free()
	remove_child(get_node(bullet_name))
		
remotesync func kill_player(player_name):
	GameManager.delete_player(player_name)
	get_node(str(player_name)).queue_free()


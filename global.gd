extends Node

var Books := 0;

const NUM_BOOKS_TO_WIN = 120

var has_met_librarian := false
var has_met_dewy := false
var is_holding_book := false
var is_hurting := false
var is_healing := false
var is_player_attacking := false
var is_enemy_attacking := false
var librarian_is_sick := false
var librarian_is_antagonist := false
var player_facing_left := false
var is_player_dead := false
var boss_battle_started := false

var books_left_to_shelve_floor_1 := 10
var books_left_to_shelve_floor_2 := 10
var books_left_to_shelve_floor_3 := 10
var books_left_to_shelve_floor_4 := 10
var books_left_to_shelve_floor_5 := 10
var books_left_to_shelve_floor_6 := 10
var books_left_to_shelve_floor_7 := 10
var books_left_to_shelve_floor_8 := 10
var books_left_to_shelve_floor_9 := 10
var books_left_to_shelve_floor_10 := 10
var books_left_to_shelve_floor_11 := 10
var books_left_to_shelve_floor_12 := 10
var books_shelved := 0

var player_health := 5
var player_max_health := 40
var player_attack_power := 1
var player_shield_strength := 1
var player_sprint_speed := 1

enum NPC {
	NONE,
	LIBRARIAN,
	DEWY
}

enum ENEMY {
	NONE,
	SKELETON, 
	SHADE
}

enum INTERACTABLE {
	NONE,
	CART,
	SHELF,
	ELEVATOR
}

enum FLOORS {
	ZEROTH,
	FIRST,
	SECOND,
	THIRD,
	FOURTH,
	FIFTH,
	SIXTH,
	SEVENTH,
	EIGHTH,
	NINTH,
	TENTH,
	ELEVENTH,
	TWELFTH
}

var talking_npc_in_range = NPC.NONE;
var enemy_in_range = ENEMY.NONE;
var interactable_object_in_range = INTERACTABLE.NONE;
var floor_number = FLOORS.ZEROTH

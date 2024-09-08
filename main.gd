
# Main.gd
extends Control

# Узлы

@onready var animation_player: AnimationPlayer = $MarginContainer/VBoxContainer/HBoxContainer3/Panel/AnimationPlayer
@onready var animation_player2: AnimationPlayer = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/button_furnace/AnimationPlayer
#@onready var animation_24_hourse: AnimationPlayer = $AnimationPlayer2
@onready var block_button: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/Panel/block_button
@onready var inventory_button: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer/inventory_button
@onready var map_button: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer/map_button
@onready var background: TextureRect = $background
@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var hit_sound_player: AudioStreamPlayer = $HitSoundPlayer
@onready var monster_spawn_timer: Timer = null
#@onready var animation_monster: AnimationPlayer = $AnimationPlayer
@onready var ClickCount_label: Label = $MarginContainer/VBoxContainer/HBoxContainer2/ClickCountLabel
@onready var pickaxe_sprite: TextureRect = $MarginContainer/VBoxContainer/HBoxContainer3/Panel/pickaxe_sprite
@onready var pickaxe_list: ItemList = $MarginContainer/VBoxContainer/HBoxContainer3/CenterContainer3/pickaxe_list
@onready var map_list: ItemList = $MarginContainer/VBoxContainer/HBoxContainer3/CenterContainer3/map_list
@onready var pickaxe_button: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer/pickaxe_button
@onready var inventory_list: ItemList = $MarginContainer/VBoxContainer/HBoxContainer3/CenterContainer3/inventory_list

#Печка
@onready var label_furnace_sec: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/label_furnace_sec
@onready var button_furnace: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/button_furnace
@onready var button_furnace_1: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/HBoxContainer/button_furnace_1
@onready var button_furnace_2: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/HBoxContainer/button_furnace_2
@onready var button_furnace_3: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/HBoxContainer/button_furnace_3
@onready var button_furnace_4: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/HBoxContainer/button_furnace_4
@onready var label_furnace_1: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/HBoxContainer/button_furnace_1/label_furnace_1
@onready var label_furnace_2: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/HBoxContainer/button_furnace_2/label_furnace_1
@onready var label_furnace_3: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/HBoxContainer/button_furnace_3/label_furnace_1
@onready var label_furnace_4: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/HBoxContainer/button_furnace_4/label_furnace_1
@onready var button_furnace_x1: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x1
@onready var button_furnace_x10: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x10
@onready var button_furnace_x25: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x25
@onready var button_furnace_x50: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x50
@onready var button_furnace_x100: TextureButton = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x100
@onready var label_furnace_x1: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x1/label_furnace_x1
@onready var label_furnace_x10: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x10/label_furnace_x10
@onready var label_furnace_x25: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x25/label_furnace_x25
@onready var label_furnace_x50: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x50/label_furnace_x50
@onready var label_furnace_x100: Label = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace/CenterContainer/VBoxContainer/CenterContainer/HFlowContainer/button_furnace_x100/label_furnace_x100
@onready var panel_furnace: Panel = $MarginContainer/VBoxContainer/HBoxContainer3/PanelFurnace
# Остальной код


var CurrentBiome = "Поляна"
var CurrentBlockType = "Грязь"
var ClickCount: int = 0  # Количество кликов (валюта)
var ClickMultiplier: int = 1  # Множитель кликов (сначала равен 1)
var CurrentPickaxe = "Дерево"  # Начальная кирка по умолчанию
var DamagePickaxe: int = 1 #Урон кирки
var TotalClicks: int = 0  # Общие клики от последнего удара
var furnace_multiplier = 1  # Множитель выпекания по умолчанию

# Переменные для хранения выбранного блока и множителя
var selected_block_name: String = ""
var selected_block_info: Dictionary = {}
var block_info: Dictionary = {}



# Данные для кирок
var PickaxeData = {
	"Дерево": {
		"Purchased": true,
		"ButtonPurchased": false,
		"RequiredBlock": "Дерево",
		"Index": 0,
		"IndexPay":1,
		"Price": 0,
		"ClickMultiplier": 1,
		"Damage": 1,
		"CritChance": 0.1,  # 5% шанс на критический удар
		"Ability": "on fire"  # Возможность кирки (например, возможность собирать бонусные блоки и т.д.)
	},
	"Глина": {
		"Purchased": false,
		"ButtonPurchased": false,
		"RequiredBlock": "Глина",
		"Index": 2,
		"IndexPay":3,
		"Price": 10,
		"ClickMultiplier": 2,
		"Damage": 2,
		"CritChance": 0.1,  # 10% шанс на критический удар
		"Ability": "on fire"
	},
	"Тыква": {
		"Purchased": false,
		"ButtonPurchased": false,
		"RequiredBlock": "Тыква",
		"Index": 4,
		"IndexPay":5,
		"Price": 10,
		"ClickMultiplier": 2,
		"Damage": 2,
		"CritChance": 0.2,  # 10% шанс на критический удар
		"Ability": "spooke_flame"
	},
	"Кактус": {
		"ButtonPurchased": false,
		"Purchased": false,
		"RequiredBlock": "Кактус",
		"Index": 6,
		"IndexPay":7,
		"Price": 25,
		"ClickMultiplier": 3,
		"Damage": 3,
		"CritChance": 0.25,  # 10% шанс на критический удар
		"Ability": "on fire"
	},
	"Песчанник": {
		"ButtonPurchased": false,
		"Purchased": false,
		"RequiredBlock": "Песчанник",
		"Index": 8,
		"IndexPay":9,
		"Price": 50,
		"ClickMultiplier": 4,
		"Damage": 5,
		"CritChance": 0.25,  # 10% шанс на критический удар
		"Ability": "on fire"
	},
	"Стекло": {
		"ButtonPurchased": false,
		"Purchased": false,
		"RequiredBlock": "Стекло",
		"Index": 10,
		"IndexPay":11,
		"Price": 10,
		"ClickMultiplier": 5,
		"Damage": 5,
		"CritChance": 0.25,  # 10% шанс на критический удар
		"Ability": "shatter"
	},
	"Берёза": {
		"ButtonPurchased": false,
		"Purchased": false,
		"RequiredBlock": "Берёза",
		"Index": 12,
		"IndexPay":13,
		"Price": 50,
		"ClickMultiplier": 5,
		"Damage": 5,
		"CritChance": 0.25,  # 10% шанс на критический удар
		"Ability": "on fire"
	},
	"Лёд": {
		"ButtonPurchased": false,
		"Purchased": false,
		"RequiredBlock": "Лёд",
		"Index": 14,
		"IndexPay":15,
		"Price": 50,
		"ClickMultiplier": 6,
		"Damage": 6,
		"CritChance": 0.25,  # 10% шанс на критический удар
		"Ability": "shatter"
	},
	"Сапфир": {
		"ButtonPurchased": false,
		"Purchased": false,
		"RequiredBlock": "Сапфир",
		"Index": 16,
		"IndexPay":17,
		"Price": 20,
		"ClickMultiplier": 7,
		"Damage": 7,
		"CritChance": 0.35,  # 10% шанс на критический удар
		"Ability": "on fire"
	},
	# Добавьте другие кирки аналогично
}
var PickaxeTextureData = {
	"Дерево": {
		"texture": load("res://textures/pickaxe/wood_pickaxe.png")
	},
	"Глина": {
		"texture": load("res://textures/pickaxe/clay_pickaxe.png")
	},
	"Тыква": {
		"texture": load("res://textures/pickaxe/pumpkin_pickaxe.png")
	},
	"Кактус": {
		"texture": load("res://textures/pickaxe/cactus_pickaxe.png")
	},
	"Песчанник": {
		"texture": load("res://textures/pickaxe/sandstone_pickaxe.png")
	},
	"Стекло": {
		"texture": load("res://textures/pickaxe/glass_pickaxe.png")
	},
	"Берёза": {
		"texture": load("res://textures/pickaxe/birchwood_pickaxe.png")
	},
	"Лёд": {
		"texture": load("res://textures/pickaxe/ice_pickaxe.png")
	},
	"Сапфир": {
		"texture": load("res://textures/pickaxe/sapphire_pickaxe.png")
	},
	# Добавьте другие кирки аналогично
}
# Текстуры блоков, количество жизней и вероятность выпадения
var BlockData = {
	"Поляна": {
		"Грязь": { 
			"Index": 0,
			"Type": "dirt",
			"Health": 2,
			"Chance": 0.35,
			"FurnanceTime": 1,
			"Furnance1": "Глина",
			"Furnance2": false,
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 2,
			"FurnanceAmount2": false,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Дерево": { 
			"Index": 1,
			"Type": "wood",
			"Health": 3,
			"Chance": 0.28,
			"FurnanceTime": 5,
			"Furnance1": "Грязь",
			"Furnance2": "Глина",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 2,
			"FurnanceAmount2": 1,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Глина": { 
			"Index": 2,
			"Type": "dirt",
			"Health": 2,
			"Chance": 0.28,
			"FurnanceTime": 4,
			"Furnance1": "Грязь",
			"Furnance2": false,
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 3,
			"FurnanceAmount2": false,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Тыква": { 
			"Index": 3,
			"Type": "pumpkin",
			"Health": 2,
			"Chance": 0.07,
			"FurnanceTime": 15,
			"Furnance1": "Грязь",
			"Furnance2": "Глина",
			"Furnance3": "Дерево",
			"Furnance4": false,
			"FurnanceAmount1": 10,
			"FurnanceAmount2": 5,
			"FurnanceAmount3": 3,
			"FurnanceAmount4": false},
	},
	"Пустыня": {
		"Песок": { 
			"Index": 4,
		 	"Type": "sand",
		 	"Health": 3,
		 	"Chance": 0.35,
			"FurnanceTime": 1,
			"Furnance1": "Грязь",
			"Furnance2": "Тыква",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 10,
			"FurnanceAmount2": 2,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Песчанник": {
			"Index": 5,
		 	"Type": "stone",
			 "Health": 5,
			 "Chance": 0.28,
			"FurnanceTime": 6,
			"Furnance1": "Кактус",
			"Furnance2": "Песок",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 1,
			"FurnanceAmount2": 3,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Кактус": {
			"Index": 6,
			"Type": "pumpkin",
			"Health": 4,
			"Chance": 0.28,
			"FurnanceTime": 3,
			"Furnance1": "Песок",
			"Furnance2": false,
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 5,
			"FurnanceAmount2": false,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Стекло": {
			"Index": 7,
			"Type": "glass",
			"Health": 3,
			"Chance": 0.07,
			"FurnanceTime": 15,
			"Furnance1": "Песок",
			"Furnance2": false,
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 35,
			"FurnanceAmount2": false,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false}
	},
	"Тундра": {
		"Лёд": {
			"Index": 8,
			"Type": "glass",
			"Health": 3,
			"Chance": 0.35,
			"FurnanceTime": 4,
			"Furnance1": "Снег",
			"Furnance2": false,
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 3,
			"FurnanceAmount2": false,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Снег": {
			"Index": 9,
			"Type": "dirt",
			"Health": 5,
			"Chance": 0.28,
			"FurnanceTime": 1,
			"Furnance1": "Песок",
			"Furnance2": "Стекло",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 10,
			"FurnanceAmount2": 2,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Берёза":  {
			"Index": 10,
			"Type": "wood",
			"Health": 4,
			"Chance": 0.28,
			"FurnanceTime": 10,
			"Furnance1": "Снег",
			"Furnance2": "Дерево",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 6,
			"FurnanceAmount2": 1,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Сапфир": {
			"Index": 11,
			"Type": "stone",
			"Health": 3,
			"Chance": 0.07,
			"FurnanceTime": 10,
			"Furnance1": "Берёза",
			"Furnance2": "Снег",
			"Furnance3": "Лёд",
			"Furnance4": false,
			"FurnanceAmount1": 2,
			"FurnanceAmount2": 5,
			"FurnanceAmount3": 4,
			"FurnanceAmount4": false}
	},
	"Пещера": {
		"Камень": {
			"Index": 12,
			"Type": "stone",
			"Health": 10,
			"Chance": 0.2,
			"FurnanceTime": 4,
			"Furnance1": "Снег",
			"Furnance2": "Сапфир",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 8,
			"FurnanceAmount2": 2,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Гравий": {
			"Index": 13,
			"Type": "sand",
			"Health": 8,
			"Chance": 0.14,
			"FurnanceTime": 1,
			"Furnance1": "Камень",
			"Furnance2": false,
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 3,
			"FurnanceAmount2": false,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Уголь":  {
			"Index": 14,
			"Type": "wood",
			"Health": 14,
			"Chance": 0.13,
			"FurnanceTime": 10,
			"Furnance1": "Гравий",
			"Furnance2": "Камень",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 2,
			"FurnanceAmount2": 1,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Железо": {
			"Index": 15,
			"Type": "stone",
			"Health": 18,
			"Chance": 0.12,
			"FurnanceTime": 10,
			"Furnance1": "Камень",
			"Furnance2": "Гравий",
			"Furnance3": "Уголь",
			"Furnance4": false,
			"FurnanceAmount1": 5,
			"FurnanceAmount2": 5,
			"FurnanceAmount3": 1,
			"FurnanceAmount4": false},
		"Красный камень":  {
			"Index": 16,
			"Type": "stone",
			"Health": 20,
			"Chance": 0.12,
			"FurnanceTime": 10,
			"Furnance1": "Железо",
			"Furnance2": "Гравий",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 2,
			"FurnanceAmount2": 5,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
		"Золото":  {
			"Index": 17,
			"Type": "stone",
			"Health": 21,
			"Chance": 0.1,
			"FurnanceTime": 10,
			"Furnance1": "Камень",
			"Furnance2": "Железо",
			"Furnance3": "Уголь",
			"Furnance4": false,
			"FurnanceAmount1": 1,
			"FurnanceAmount2": 2,
			"FurnanceAmount3": 1,
			"FurnanceAmount4": false},
		"Алмаз":  {
			"Index": 18,
			"Type": "stone",
			"Health": 27,
			"Chance": 0.05,
			"FurnanceTime": 10,
			"Furnance1": "Камень",
			"Furnance2": "Золото",
			"Furnance3": "Красный камень",
			"Furnance4": false,
			"FurnanceAmount1": 10,
			"FurnanceAmount2": 2,
			"FurnanceAmount3": 1,
			"FurnanceAmount4": false},
		"Медь":  {
			"Index": 19,
			"Type": "stone",
			"Health": 11,
			"Chance": 0.12,
			"FurnanceTime": 10,
			"Furnance1": "Уголь",
			"Furnance2": "Камень",
			"Furnance3": false,
			"Furnance4": false,
			"FurnanceAmount1": 2,
			"FurnanceAmount2": 3,
			"FurnanceAmount3": false,
			"FurnanceAmount4": false},
	},
	# Добавьте другие биомы аналогично
}
var BlockDataInventory = {
	"Грязь": { 
		"Index": 0,
		"Inventory": 0},
	"Дерево": { 
		"Index": 1,
		"Inventory": 0 },
	"Глина": { 
		"Index": 2,
		"Inventory": 0 },
	"Тыква": { 
		"Index": 3,
		"Inventory": 0 },
	"Песок": { 
		"Index": 4,
		"Inventory": 0 },
	"Песчанник": {
		"Index": 5,
		"Inventory": 0 },
	"Кактус": {
		"Index": 6,
		"Inventory": 0 },
	"Стекло": {
		"Index": 7,
		"Inventory": 0 },
	"Лёд": {
		"Index": 8,
		"Inventory": 0 },
	"Снег": {
		"Index": 9,
		"Inventory": 0 },
	"Берёза":  {
		"Index": 10,
		"Inventory": 0 },
	"Сапфир": {
		"Index": 11,
		"Inventory": 0 },
	"Камень": {
		"Index": 12,
		"Inventory": 0 },
	"Гравий": {
		"Index": 13,
		"Inventory": 0 },
	"Уголь":  {
		"Index": 14,
		"Inventory": 0 },
	"Железо": {
		"Index": 15,
		"Inventory": 0 },
	"Красный камень":  {
		"Index": 16,
		"Inventory": 0 },
	"Золото":  {
		"Index": 17,
		"Inventory": 0 },
	"Алмаз":  {
		"Index": 18,
		"Inventory": 0 },
	"Медь":  {
		"Index": 19,
		"Inventory": 0 },
}

var block_texture_data = {
	"Поляна": {
		"Грязь": { 
			"texture": load("res://textures/glade/dirt_block.png")},
		"Дерево": { 
			"texture": load("res://textures/glade/oak_wood_block.png")},
		"Глина": { 
			"texture": load("res://textures/glade/clay_block.png")},
		"Тыква": { 
			"texture": load("res://textures/glade/pumpkin_block.png")},
	},
	"Пустыня": {
		"Песок": { 
			"texture": load("res://textures/desert/sand_block.png")},
		"Песчанник": {
			"texture": load("res://textures/desert/sandstone_block.png")},
		"Кактус": {
			"texture": load("res://textures/desert/cactus_block.png")},
		"Стекло": {
			 "texture": load("res://textures/desert/glass_block.png")},
	},
	"Тундра": {
		"Лёд": {
			"texture": load("res://textures/tundra/ice_block.png")},
		"Снег": {
			"texture": load("res://textures/tundra/snow_block.png")},
		"Берёза":  {
			"texture": load("res://textures/tundra/birch_block.png")},
		"Сапфир": {
			"texture": load("res://textures/tundra/sapphire_block.png")},
	},
	"Пещера": {
		"Камень": { 
			"texture": load("res://textures/cave/stone_block.png")},
		"Гравий": {
			"texture": load("res://textures/cave/gravel_block.png")},
		"Уголь": {
			"texture": load("res://textures/cave/coal_block.png")},
		"Железо": {
			 "texture": load("res://textures/cave/iron_block.png")},
		"Красный камень": {
			 "texture": load("res://textures/cave/redstone_block.png")},
		"Золото": {
			 "texture": load("res://textures/cave/gold_block.png")},
		"Алмаз": {
			 "texture": load("res://textures/cave/diamond_block.png")},
		"Медь": {
			 "texture": load("res://textures/cave/copper_block.png")},
	},
}
var monster_data = {
	"creeper": { 
		"texture": load("res://textures/monsters/creeper_mob.png"), 
		"Health": 20,
		"Damage": 3,
		"Chance":0.5,
		"Biom": "Поляна",
		"SpawnSound": load("res://sounds/mob/creeper/say1.ogg"),
		"HitSound": load("res://sounds/mob/creeper/say2.ogg"),
		"DeathSound": load("res://sounds/mob/creeper/death.ogg")},
	"zombie": { 
		"texture": load("res://textures/monsters/zombie_mob.png"), 
		"Health": 20,
		"Damage": 3,
		"Chance":0.5,
		"Biom": "Поляна",
		"SpawnSound": load("res://sounds/mob/zombie/say1.ogg"),
		"HitSound": load("res://sounds/mob/zombie/hurt1.ogg"),
		"DeathSound": load("res://sounds/mob/zombie/death.ogg")},
	"spider": { 
		"texture": load("res://textures/monsters/spider_mob.png"), 
		"Health": 16,
		"Damage": 3,
		"Chance":0.5,
		"Biom": "Поляна",
		"SpawnSound": load("res://sounds/mob/spider/step1.ogg"),
		"HitSound": load("res://sounds/mob/spider/say3.ogg"),
		"DeathSound": load("res://sounds/mob/spider/death.ogg")},
	"skeleton": { 
		"texture": load("res://textures/monsters/skeleton_mob.png"), 
		"Health": 20,
		"Damage": 3,
		"Chance":0.5,
		"Biom": "Поляна",
		"SpawnSound": load("res://sounds/mob/skeleton/hurt1.ogg"),
		"HitSound": load("res://sounds/mob/skeleton/hurt2.ogg"),
		"DeathSound": load("res://sounds/mob/skeleton/death.ogg")}
}

# Текстуры фонов для биомов
var BiomeData = {
	"Поляна": {
		"Index": 0,
		},
	"Пустыня": {
		"Index": 1,
		},
	"Тундра": {
		"Index": 2,
		},
	"Пещера": {
		"Index": 3,
		}
	# Добавьте другие биомы аналогично
}
var BiomeMusicData = {
	"Поляна": {
		"Music": [
		load("res://music/glade_track_1.mp3"),
		load("res://music/glade_track_2.mp3"),
		load("res://music/glade_track_3.mp3")]
		},
	"Пустыня": {
		"Music": [
		load("res://music/desert_track_1.mp3"),
		load("res://music/desert_track_2.mp3"),
		load("res://music/desert_track_3.mp3")]
		},
	"Тундра": {
		"Music": [
		load("res://music/tundra_track_1.mp3"),
		load("res://music/tundra_track_2.mp3"),
		load("res://music/tundra_track_3.mp3")]
		},
	"Пещера": {
		"Music": [
		load("res://music/cave_track_1.mp3"),
		load("res://music/cave_track_2.mp3"),
		load("res://music/cave_track_3.mp3")]
		}
	# Добавьте другие биомы аналогично
}
var BiomeTextureData = {
	"Поляна": {
		"texture": load("res://textures/glade/background_glade.png")},
	"Пустыня": {
		"texture": load("res://textures/desert/background_desert.png")},
	"Тундра": {
		"texture": load("res://textures/tundra/background_tundra.png")},
	"Пещера": {
		"texture": load("res://textures/cave/background_cave.png")}
	# Добавьте другие биомы аналогично
}

# Звуки для блоков
var hit_sounds = {
	"dirt": [
		preload("res://sounds/dirt_hit/dirt_hit_1.mp3"),
		preload("res://sounds/dirt_hit/dirt_hit_2.mp3"),
		preload("res://sounds/dirt_hit/dirt_hit_3.mp3"),
		preload("res://sounds/dirt_hit/dirt_hit_4.mp3")
	],
	"wood": [
		preload("res://sounds/wood_hit/wood_hit_1.mp3"),
		preload("res://sounds/wood_hit/wood_hit_2.mp3"),
		preload("res://sounds/wood_hit/wood_hit_3.mp3"),
		preload("res://sounds/wood_hit/wood_hit_4.mp3")
	],
	"pumpkin": [
		preload("res://sounds/pumpkin_hit/pumpkin_hit_1.mp3"),
		preload("res://sounds/pumpkin_hit/pumpkin_hit_2.mp3")
	],
	"sand": [
		preload("res://sounds/sand_hit/sand_hit_1.mp3"),
		preload("res://sounds/sand_hit/sand_hit_2.mp3"),
		preload("res://sounds/sand_hit/sand_hit_3.mp3"),
		preload("res://sounds/sand_hit/sand_hit_4.mp3")
	],
	"glass": [
		preload("res://sounds/glass_hit/glass_hit_1.mp3"),
		preload("res://sounds/glass_hit/glass_hit_2.mp3"),
		preload("res://sounds/glass_hit/glass_hit_3.mp3")
	],
	"stone": [
		preload("res://sounds/stone_hit/stone_hit_1.mp3"),
		preload("res://sounds/stone_hit/stone_hit_2.mp3"),
		preload("res://sounds/stone_hit/stone_hit_3.mp3")
	],
	# Добавьте другие типы блоков и звуки
}
var CurrentHealth = BlockData[CurrentBiome][CurrentBlockType]["Health"]  # Начальное количество жизней текущего блока
var BiomeSelectionInstance: Node = null  # Переменная для экземпляра выбора биома


func _ready():
	apply_game_data()
	local_load_game()
	# Программно выбираем первый элемент в ItemList
	if inventory_list.get_item_count() > 0:
		inventory_list.select(0)  # Выбираем первый блок
		_on_inventory_item_selected(0)  # Вызываем обработчик выбора
	#Загрузка
	#$igbgui.connect("data_loaded", Callable(self, "igb_data_loaded"))
	#$igbgui.data_key.assign(["key1"])
	#$igbgui.on_load_data()
	


	pickaxe_list.connect("item_selected", Callable(self, "_on_pickaxe_selected"))
	map_list.connect("item_selected", Callable(self, "_on_map_selected"))
	inventory_list.connect("item_selected", Callable(self, "_on_inventory_item_selected"))
	button_furnace_x1.connect("pressed", Callable(self, "_on_furnace_multiplier_button_pressed").bind(1))
	button_furnace_x10.connect("pressed", Callable(self, "_on_furnace_multiplier_button_pressed").bind(10))
	button_furnace_x25.connect("pressed", Callable(self, "_on_furnace_multiplier_button_pressed").bind(25))
	button_furnace_x50.connect("pressed", Callable(self, "_on_furnace_multiplier_button_pressed").bind(50))
	button_furnace_x100.connect("pressed", Callable(self, "_on_furnace_multiplier_button_pressed").bind(100))
	button_furnace.connect("pressed",  Callable(self, "_on_button_furnace_pressed"))
	
	#GRA
	$igbgui.set_game_ready()
func _on_block_button_button_down() -> void:
	animation_player.play("animation_block")

	# Создание экземпляра падающего текста
	var falling_text = RigidBody2D.new()
	var rand_x = randf_range(0, get_viewport_rect().size.x) # Случайная позиция по оси X
	falling_text.position = Vector2(rand_x, -50) # Начальная позиция чуть выше экрана
	falling_text.gravity_scale = 1.0 # Установка гравитационного коэффициента

	# Создание и настройка Label
	var text_label = Label.new()
	text_label.text = str(TotalClicks)  # Установка текста
	text_label.set_position(Vector2(0, 0)) # Установка начальной позиции
	falling_text.add_child(text_label) # Добавление Label в RigidBody2D

	# Установка размера текста
	text_label.scale = Vector2(1, 1) # Измените масштаб текста, если нужно
	# Добавление в сцену
	get_node("/root").add_child(falling_text)

	# Добавление вращения
	falling_text.angular_velocity = randf_range(-3.0, 3.0) # Установка случайной угловой скорости


	CurrentHealth -= PickaxeData[CurrentPickaxe]["Damage"]
	
	# Определяем множитель кликов текущей кирки
	var current_ClickMultiplier = PickaxeData[CurrentPickaxe]["ClickMultiplier"]
	
	# Проверяем шанс на критический удар
	var CritChance = PickaxeData[CurrentPickaxe]["CritChance"] 
	var is_crit = randf() < CritChance
	
	if is_crit:
		print("Critical hit!")
		TotalClicks = current_ClickMultiplier * 2  # Удваиваем количество кликов за критический удар
	else:
		TotalClicks = current_ClickMultiplier  # Обычный удар

	ClickCount += TotalClicks  # Обновляем общее количество кликов
	#save_game()
	
	update_ClickCount_label()  # Обновляем метку общего количества кликов
	play_hit_sound()
	local_save_game()
	# Остальная часть кода...

	

	if CurrentHealth <= 0:
	# Обновляем количество блока в BlockData
		BlockDataInventory[CurrentBlockType]["Inventory"] += 1
	# Обновляем текст в inventory_list
		update_inventory_list()
		update_button_states()
		# Падающие блоки
		var give_block = RigidBody2D.new() # Создание экземпляра твердого тела
		var rand_xx = randf_range(0, get_viewport_rect().size.x)
		give_block.position = Vector2(rand_xx, -block_button.texture_normal.get_height()) # Установка начальной позиции сверху экрана
		give_block.gravity_scale = 1.0 # Установка гравитационного коэффициента
		var give_block_sprite = Sprite2D.new() # Создание спрайта
		give_block_sprite.texture = block_button.texture_normal # Установка текстуры
		give_block.add_child(give_block_sprite) # Добавление спрайта
		give_block_sprite.scale = Vector2(0.2, 0.2)
		get_node("/root").add_child(give_block) # Добавление в сцену в главной ветке

		# Добавление вращения
		give_block.angular_velocity = randf_range(-20.0, 20.0) # Установка случайной угловой скорости

		# Удаление блока после падения
		var timer = Timer.new()
		timer.wait_time = 2  # Время, через которое блок будет удален
		timer.one_shot = true
		timer.connect("timeout", Callable(give_block, "queue_free"))
		timer.connect("timeout", Callable(falling_text, "queue_free"))
		give_block.add_child(timer)
		timer.start()
		update_block_texture()
	else:
		update_block_color()

	print("Block pressed. Current Health: %d" % CurrentHealth)  # Отладочное сообщение
	

func update_block_color():
	var max_health = BlockData[CurrentBiome][CurrentBlockType]["Health"]
	var health_stage = int((1 - float(CurrentHealth) / max_health) * 10)
	var darkness = 1 - health_stage * 0.1
	block_button.self_modulate = Color(darkness, darkness, darkness)

func play_hit_sound():
	# Проверка существования ключей в BlockData перед доступом к ним
	if CurrentBiome in BlockData and CurrentBlockType in BlockData[CurrentBiome]:
		var block_type = BlockData[CurrentBiome][CurrentBlockType].get("Type", null)
		if block_type != null and block_type in hit_sounds:
			var sounds = hit_sounds[block_type]
			var random_Index = randi() % sounds.size()
			hit_sound_player.stream = sounds[random_Index]
			hit_sound_player.play()
	else:
		print("Ошибка: Несуществующий блок или биом")



#Обновление количества кликов
func update_ClickCount_label():
	ClickCount_label.text = "Кликов: " + format_number(ClickCount)
	

#Улучшение количества кликов за удар
func upgrade_ClickMultiplier(amount: int):
	ClickMultiplier += amount
	print("Click multiplier upgraded! New multiplier: %d" % ClickMultiplier)




func _on_pickaxe_button_pressed() -> void:
	$igbgui.on_show_banner()
	map_list.visible = false
	inventory_list.visible = false
	panel_furnace.visible = false
	pickaxe_list.visible = !pickaxe_list.visible
	pass # Replace with function body.

func _on_map_button_pressed() -> void:
	$igbgui.on_show_interstitial()

	pickaxe_list.visible = false
	inventory_list.visible = false
	panel_furnace.visible = false
	map_list.visible = !map_list.visible
	pass # Replace with function body.

func _on_inventory_button_pressed() -> void:
	pickaxe_list.visible = false
	map_list.visible = false
	inventory_list.visible = !inventory_list.visible
	panel_furnace.visible = !panel_furnace.visible
	pass # Replace with function body.


func _on_map_selected(Index: int):
	for biome_name in BiomeData:
		if BiomeData[biome_name]["Index"] == Index:
			set_biome(biome_name)
			
			break


func set_biome(biome_name: String):
	if biome_name in BiomeData:
		CurrentBiome = biome_name
		background.texture = BiomeTextureData[CurrentBiome]["texture"]
		# Установим начальный блок для нового биома
		update_block_texture()
		var biome_Index = BiomeData[biome_name]["Index"]
		map_list.select(biome_Index)
		play_random_music()
		print("Biome set to: %s" % CurrentBiome)
	else:
		print("Biome not found: %s" % biome_name)


func reset_block_health():
	if CurrentBlockType in BlockData[CurrentBiome]:
		CurrentHealth = BlockData[CurrentBiome][CurrentBlockType]["Health"]
		block_button.self_modulate = Color(1, 1, 1)  # Сбрасываем цвет блока
		print("Block Health reset to: %d" % CurrentHealth)
	else:
		print("Invalid block Type for biome: %s" % CurrentBlockType)

func update_biome_texture():
	var biome_texture = BiomeData[CurrentBiome]["texture"]
	background.texture = biome_texture

func play_random_music():
	var biome_music = BiomeMusicData[CurrentBiome]["Music"]
	if biome_music.size() > 0:
		var random_music = biome_music[randi() % biome_music.size()]
		music_player.stream = random_music
		music_player.play()

func update_block_texture():
	# Получаем данные о блоке из текущего биома
	var blocks_in_biome = BlockData.get(CurrentBiome, null)
	var texture_block = block_texture_data.get(CurrentBiome, null)
	if blocks_in_biome == null or texture_block == null:
		print("Ошибка: Блоки или текстуры для текущего биома не найдены.")
		return
	
	# Определяем новый блок для установки, основываясь на шансах выпадения
	var random_value = randf()
	var cumulative_chance = 0.0
	for block_name in blocks_in_biome.keys():
		cumulative_chance += blocks_in_biome[block_name]["Chance"]
		if random_value <= cumulative_chance:
			CurrentBlockType = block_name
			break
	
	# Проверяем наличие текстуры для нового блока перед её установкой
	if texture_block.has(CurrentBlockType):
		block_button.texture_normal = texture_block[CurrentBlockType]["texture"]
		reset_block_health()
		print("Текстура блока обновлена на %s в биоме %s" % [CurrentBlockType, CurrentBiome])
	else:
		print("Ошибка: Текстура для блока %s в биоме %s не найдена." % [CurrentBlockType, CurrentBiome])


func _on_audio_stream_player_finished():
	play_random_music()
	pass # Replace with function body.

func update_inventory_list():
	for block_name in BlockDataInventory:
		var block_info = BlockDataInventory[block_name]
		var block_index = block_info["Index"]
		var block_inventory = block_info["Inventory"]

		inventory_list.set_item_text(block_index, "%s: %d" % [block_name, block_inventory])
		inventory_list.set_item_disabled(block_index, block_inventory <= 0)


func _on_pickaxe_selected(index):
	for pickaxe_name in PickaxeData.keys():
		var pickaxe_info = PickaxeData[pickaxe_name]
		var pickaxe_index = pickaxe_info["Index"]
		var button_index = pickaxe_info["IndexPay"]
		
		if index == button_index and not pickaxe_list.is_item_disabled(button_index):
			purchase_pickaxe(pickaxe_name)
		elif index == pickaxe_index and not pickaxe_list.is_item_disabled(pickaxe_index):
			set_pickaxe(pickaxe_name)

	update_inventory_list()
func purchase_pickaxe(pickaxe_name):
	var pickaxe_info = PickaxeData[pickaxe_name]
	var required_block_type = pickaxe_info["RequiredBlock"]
	var price = pickaxe_info["Price"]

	if BlockDataInventory[required_block_type]["Inventory"] >= price:
		BlockDataInventory[required_block_type]["Inventory"] -= price
		pickaxe_info["Purchased"] = true
		update_button_states()
		print("Purchased pickaxe: %s" % pickaxe_name)


func set_pickaxe(pickaxe_name: String):
	if pickaxe_name in PickaxeData:
		CurrentPickaxe = pickaxe_name
		var pickaxe_index = PickaxeData[pickaxe_name]["Index"]
		pickaxe_list.select(pickaxe_index)
		update_pickaxe_texture()
		print("Selected pickaxe: %s" % pickaxe_name)

func update_pickaxe_texture():
	var pickaxe_texture = PickaxeTextureData[CurrentPickaxe]["texture"]
	pickaxe_sprite.texture = pickaxe_texture
	
func update_button_states():
	for pickaxe_name in PickaxeData.keys():
		var pickaxe_info = PickaxeData[pickaxe_name]
		var pickaxe_index = pickaxe_info["Index"]
		var button_index = pickaxe_info["IndexPay"]
		var price = pickaxe_info["Price"]
		var required_block_type = pickaxe_info["RequiredBlock"]

		if pickaxe_info["Purchased"]:
			pickaxe_list.set_item_disabled(button_index, true)
			pickaxe_list.set_item_disabled(pickaxe_index, false)
		elif BlockDataInventory[required_block_type]["Inventory"] >= price:
			pickaxe_list.set_item_disabled(button_index, false)
		else:
			pickaxe_list.set_item_disabled(button_index, true)

# Функции ПЕЧКИ!
# Вызывается при запуске, чтобы выбрать блок по умолчанию
# Обработчик выбора блока из списка
# Обработчик выбора блока из списка
func _on_inventory_item_selected(index: int):
	selected_block_info = {}  # Инициализируем как пустой словарь
	selected_block_name = ""

	# Поиск блока по индексу в BlockDataInventory
	for block_name in BlockDataInventory:
		if BlockDataInventory[block_name]["Index"] == index:
			selected_block_name = block_name
			selected_block_info = BlockDataInventory[block_name]
			break

	# Проверка, пуст ли словарь
	if selected_block_info.size() == 0:  # Используем size() для проверки
		print("Блок не найден для индекса: ", index)
		return

	# Установка текстуры основной кнопки печи
	button_furnace.texture_normal = get_global_block_texture(selected_block_name)

	# Обновление материалов для выпекания
	update_furnace_materials(selected_block_name)
	update_multiplier_buttons(selected_block_name)
	update_furnace_button_state(selected_block_name)

# Функция получения текстуры блока глобально
func get_global_block_texture(block_name: String) -> Texture:
	for biome in block_texture_data:
		if block_texture_data[biome].has(block_name):
			return block_texture_data[biome][block_name]["texture"]
	return null  # Если текстура не найдена
func update_furnace_materials(block_name: String):
	var block_info = BlockDataInventory[block_name]
	# Обновляем состояние кнопок материалов (button_furnace_1, button_furnace_2 и т.д.)
	for i in range(1, 5):
		var furnance_key = "Furnance%d" % i
		var amount_key = "FurnanceAmount%d" % i
		var button = get_furnace_button(i)
		var label = get_furnace_label(i)

		if BlockData[block_name].has(furnance_key):
			var material_name = BlockData[block_name][furnance_key]
			button.texture_normal = get_global_block_texture(material_name)
			label.text = str(BlockData[block_name][amount_key] * furnace_multiplier)
			button.visible = true
			label.visible = true
		else:
			button.visible = false
			label.visible = false
# Получение кнопок для печи
func get_furnace_button(i: int) -> TextureButton:
	match i:
		1: return button_furnace_1
		2: return button_furnace_2
		3: return button_furnace_3
		4: return button_furnace_4
		_:
			return null  # Возвращаем null, если i не соответствует ожидаемым значениям

# Получение меток для печи
func get_furnace_label(i: int) -> Label:
	match i:
		1: return label_furnace_1
		2: return label_furnace_2
		3: return label_furnace_3
		4: return label_furnace_4
		_:
			return null  # Возвращаем null, если i не соответствует ожидаемым значениям

# Проверка доступности множителей
func update_multiplier_buttons(block_name: String):
	var block_info = BlockDataInventory[block_name]
	var multipliers = [1, 10, 25, 50, 100]
	var multiplier_buttons = [button_furnace_x1, button_furnace_x10, button_furnace_x25, button_furnace_x50, button_furnace_x100]

	for i in range(multipliers.size()):
		var button = multiplier_buttons[i]
		var multiplier = multipliers[i]
		if has_enough_materials(block_info, multiplier):
			button.disabled = false
			button.modulate = Color(1, 1, 1, 1)  # Активная кнопка
		else:
			button.disabled = true
			button.modulate = Color(0.5, 0.5, 0.5, 1)  # Затемнённая кнопка
# Функция вычитания материалов
func deduct_materials(block_name: String):
	for i in range(1, 5):
		var furnance_key = "Furnance%d" % i
		var amount_key = "FurnanceAmount%d" % i

		for biome in BlockData:
			if BlockData[biome].has(block_name):
				var block_info = BlockData[biome][block_name]

				if block_info.has(furnance_key) and typeof(block_info[furnance_key]) == TYPE_STRING and block_info[furnance_key] != "":
					var material_name = block_info[furnance_key]
					var required_amount = block_info[amount_key] * furnace_multiplier
					var available_amount = BlockDataInventory[material_name]["Inventory"]

					# Проверяем, чтобы количество не ушло в минус
					if available_amount >= required_amount:
						BlockDataInventory[material_name]["Inventory"] -= required_amount

	update_inventory_list()
# Проверка на наличие достаточного количества материалов
func has_enough_materials(block_info: Dictionary, multiplier: int = 1) -> bool:
	for i in range(1, 5):
		var furnance_key = "Furnance%d" % i
		var amount_key = "FurnanceAmount%d" % i

		if block_info.has(furnance_key) and typeof(block_info[furnance_key]) == TYPE_STRING:
			var block_name = block_info[furnance_key]
			if BlockDataInventory.has(block_name):
				if BlockDataInventory[block_name]["Inventory"] < block_info[amount_key] * multiplier:
					return false
			else:
				return false
	return true
# Запуск процесса выпекания
func start_furnace():
	var block_name = selected_block_name

	# Проверка, достаточно ли материалов
	if not has_enough_materials(block_name, furnace_multiplier):
		print("Недостаточно материалов для выпекания!")
		return

	deduct_materials(block_name)

	button_furnace.disabled = true  # Блокируем кнопку выпекания
	disable_multiplier_buttons(true)  # Отключаем кнопки множителей

	for biome in BlockData:
		if BlockData[biome].has(block_name):
			var block_info = BlockData[biome][block_name]
			var furnace_time = block_info["FurnanceTime"] * furnace_multiplier
			label_furnace_sec.text = str(furnace_time) + " сек."

			var furnace_timer = Timer.new()
			furnace_timer.wait_time = furnace_time
			furnace_timer.one_shot = true
			furnace_timer.connect("timeout", Callable(self, "_on_furnace_finished").bind(block_name))
			add_child(furnace_timer)
			furnace_timer.start()

			animate_furnace_button(furnace_time)
			break

# Обработчик завершения выпекания
func _on_furnace_finished(block_name: String):
	button_furnace.disabled = false  # Разблокируем кнопку выпекания
	button_furnace.modulate = Color(1, 1, 1, 1)
	disable_multiplier_buttons(false)  # Включаем кнопки множителей

	# Добавляем выпеченный предмет в инвентарь
	BlockDataInventory[block_name]["Inventory"] += furnace_multiplier
	update_inventory_list()

	print("Выпекание завершено.")

# Анимация кнопки выпекания
func animate_furnace_button(furnace_time: float):
	var step_time = furnace_time / 100.0
	for i in range(101):
		var brightness = float(i) / 100.0
		await get_tree().create_timer(step_time).timeout
		button_furnace.modulate = Color(1, 1, 1, brightness)

# Обновляем состояние кнопки выпекания
		button_furnace.modulate = Color(0.5, 0.5, 0.5, 1)
# Обновляем состояние кнопки выпекания
func update_furnace_button_state(block_name: String):
	if has_enough_materials(BlockDataInventory[block_name], furnace_multiplier):
		button_furnace.disabled = false
		button_furnace.modulate = Color(1, 1, 1, 1)
	else:
		button_furnace.disabled = true
		button_furnace.modulate = Color(0.5, 0.5, 0.5, 1)

# Включаем или отключаем кнопки множителей
func disable_multiplier_buttons(disable: bool):
	var multiplier_buttons = [
		button_furnace_x1, 
		button_furnace_x10, 
		button_furnace_x25, 
		button_furnace_x50, 
		button_furnace_x100
	]

	for button in multiplier_buttons:
		button.disabled = disable

# Обработчик нажатия на кнопку выпекания
func _on_button_furnace_pressed():
	animation_player2.play("animation_furnance_button")
	if not start_furnace():
		print("Выпекание не началось, недостаточно материалов")

func format_number(value: int) -> String:
	if value >= 1_000_000_000_000:
		return "%.2f трлн." % (float(value) / 1_000_000_000_000)
	elif value >= 1_000_000_000:
		return "%.2f млрд." % (float(value) / 1_000_000_000)
	elif value >= 1_000_000:
		return "%.2f млн." % (float(value) / 1_000_000)
	elif value >= 1_000:
		return "%.2f тыс." % (float(value) / 1_000)
	else:
		return str(value)



func save_game():
	var data_one = {
		"CurrentBiome": CurrentBiome,
		"CurrentBlockType": CurrentBlockType,
		"CurrentHealth": CurrentHealth,
		"ClickCount": ClickCount,
		"ClickMultiplier": ClickMultiplier,
		"CurrentPickaxe": CurrentPickaxe,
		"BlockData": BlockData if BlockData != null else {},
		"PickaxeData": PickaxeData if PickaxeData != null else {}
	}
	$igbgui.data_key.assign(["key1"])
	$igbgui.data_value.assign([str(data_one)])
	$igbgui.on_save_data()

		
func apply_game_data():
	
	
	update_ClickCount_label()
	update_inventory_list()
	update_button_states()
	set_biome(CurrentBiome)
	set_pickaxe(CurrentPickaxe)  # устанавливаем начальную кирку
	
	# Здесь вы должны применить загруженные данные к игровым объектам и логике
	# Например:
	# - Обновить интерфейс
	# - Применить данные к персонажу/игровым объектам
	# - Перезагрузить текстуры и т.д.
	pass
	
# Сериализация словаря в строку

func igb_data_loaded():
	print("data loaded!")
	var data_one = int($igbgui.data_value[0])
	CurrentBiome = $igbgui.data["CurrentBiome"]
	CurrentBlockType = $igbgui.data["CurrentBlockType"]
	BlockData = $igbgui.data["BlockData"]
	CurrentHealth = $igbgui.data["CurrentHealth"]
	ClickCount = $igbgui.data["ClickCount"]
	ClickMultiplier = $igbgui.data["ClickMultiplier"]
	CurrentPickaxe = $igbgui.data["CurrentPickaxe"]
	PickaxeData = $igbgui.data["PickaxeData"]
	apply_game_data()
	


func local_save_game():

	$rdhub_savesystem.data["BlockDataInventory"] = BlockDataInventory
	$rdhub_savesystem.data["PickaxeData"] = PickaxeData
	$rdhub_savesystem.data["CurrentBiome"] = CurrentBiome
	$rdhub_savesystem.data["CurrentBlockType"] = CurrentBlockType
	$rdhub_savesystem.data["CurrentHealth"] = CurrentHealth
	$rdhub_savesystem.data["ClickCount"] = ClickCount
	$rdhub_savesystem.data["ClickMultiplier"] = ClickMultiplier
	$rdhub_savesystem.data["CurrentPickaxe"] = CurrentPickaxe 
	
	
	$rdhub_savesystem.save_file()
	print($rdhub_savesystem.data)
func local_load_game():
	# Загрузить данные
	$rdhub_savesystem.load_file()

	# Обновление словарей и переменных, только если они существуют в сохраненных данных
	BlockDataInventory = $rdhub_savesystem.data.get("BlockDataInventory", BlockDataInventory)
	CurrentBiome = $rdhub_savesystem.data.get("CurrentBiome", CurrentBiome)
	CurrentBlockType = $rdhub_savesystem.data.get("CurrentBlockType", CurrentBlockType)
	CurrentHealth = $rdhub_savesystem.data.get("CurrentHealth", 100)
	ClickCount = $rdhub_savesystem.data.get("ClickCount", 0)
	ClickMultiplier = $rdhub_savesystem.data.get("ClickMultiplier", 1)
	CurrentPickaxe = $rdhub_savesystem.data.get("CurrentPickaxe", "Дерево")
	PickaxeData = $rdhub_savesystem.data.get("PickaxeData", PickaxeData)

	# Применить загруженные данные
	apply_game_data()
	print($rdhub_savesystem.data)  # Проверьте структуру словаря после загрузки
 


func _on_block_button_pressed() -> void:
	pass # Replace with function body.


func _on_button_furnace_button_down() -> void:
	pass # Replace with function body.

extends Node

var viewport_scale
var viewport_res

#Cena atual
var currentScene = null

func _ready():
	var viewport = get_node("/root").get_children()[1].get_viewport_rect().size
	viewport_res = viewport
	viewport_scale = 144/viewport.y
	
	#Ao carregar seta a cena atual para a última cena disponível
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)

# Função pra trocar de cena
func setScene(scene):
   #Limpa a cena atual
   currentScene.queue_free()
   #Carrega o arquivo que foi passado por parametro
   var s = ResourceLoader.load(scene)
   #Cria uma instancia da cena
   currentScene = s.instance()
   # Adiciona a cena ao no raiz
   get_tree().get_root().add_child(currentScene)
extends Node2D

var available_locales = ["en", "es"]

func change_language(locale: String):
	# Establece el idioma actual
	TranslationServer.set_locale(locale)
# Llama a change_language() desde el menú para cambiar el idioma

###############NO CONECTADO AUN PORQUE NO HAY MENU###############

func _on_menu_change_language(locale: String):
	change_language(locale)
	
###############

func _on_ready():
		# Configura el idioma predeterminado
	change_language("es")

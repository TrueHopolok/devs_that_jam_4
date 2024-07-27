extends Node

const fish_names: Array[String] = [
	"Salmon",
	"Tuna",
	"Trout",
	"Cod",
	"Herring",
	"Mackerel",
	"Catfish",
	"Bass",
	"Grouper",
	"Snapper"
]

const adjective: Array[String] = [
	"Aquatic",
	"Scaly",
	"Slippery",
	"Shiny",
	"Silvery",
	"Slimy",
	"Colorful",
	"Graceful",
	"Agile",
	"Swift",
	"Fresh",
	"Saltwater",
	"Predatory",
	"Elusive",
	"Exotic",
	"Vibrant",
	"Iridescent",
	"Speckled",
	"Striped",
	"Spotted",
	"Luminous",
	"Translucent",
	"Camouflaged",
	"Glimmering",
	"Flickering",
	"Streamlined",
	"Robust",
	"Hardy",
	"Delicate",
	"Plump",
	"Lean",
	"Bony",
	"Cartilaginous",
	"Predominant",
	"Nocturnal",
	"Solitary",
	"Schooling",
	"Cold-blooded",
	"Mysterious",
	"Magnificent"
]


func next() -> String:
	return adjective.pick_random() + " " + fish_names.pick_random()

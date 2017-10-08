


nItems= 10
layers = []
maximumHeight = 400
minimumHeight = 150


imageList = new PageComponent
	size: Screen.size
	scrollHorizontal: false
	originY: 0
	backgroundColor: null
	
# SETTING UP THE ITEMS
for i in [0...nItems]
	layer = new Layer
		width: Screen.width
		backgroundColor: Utils.randomColor()
		image: Utils.randomImage()
	layers.push(layer)
	if i == 0
		layer.height = maximumHeight
	else
		layer.height = minimumHeight
		layer.y = layers[i-1].y + layers[i-1].height 
	title = new TextLayer
		parent: layer
		text: "Item " + i
		color: "#fff"
		fontSize: 20
		x: Align.center()
		y: Align.center()
	layer.parent = imageList.content

# WE NEED A SPACER TO COMPENSATE THE ITEM RESIZING WITHIN THE PAGE COMPONENT
spacer = new Layer
	width: Screen.width
	backgroundColor: "white"
	height: maximumHeight * nItems
	y: layers[nItems- 1].y + minimumHeight
	parent: imageList.content
spacer.bringToFront()

# ACTION
imageList.onMove ->
	for layer in imageList.content.children
		if layer.screenFrame.y < maximumHeight && layer != spacer
			layer.height = Utils.modulate layer.screenFrame.y, [maximumHeight,0], [minimumHeight,maximumHeight], true
		else
			layer.y = previous.y + previous.height
		previous = layer

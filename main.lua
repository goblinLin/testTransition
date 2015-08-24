-----------------------------------------------------------------------------------------
--
-- main.lua
-- 本範例示範如何使用transition，用以產生移動動畫，更多細節請參考以下網址
-- https://docs.coronalabs.com/api/library/transition/to.html
-- Author: Zack Lin
-- Time: 2015/8/24
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
display.setStatusBar( display.HiddenStatusBar )

local widget = require( "widget" )
--=======================================================================================
--宣告各種變數
--=======================================================================================
_SCREEN = {
	WIDTH = display.viewableContentWidth,
	HEIGHT = display.viewableContentHeight
}
_SCREEN.CENTER = {
	X = display.contentCenterX,
	Y = display.contentCenterY
}
local img
local btn_play
local btn_stop
local transitionGo
local transitionBack

local origin_alpha = 0.6
local orign_x = _SCREEN.CENTER.X + 120
-- 函式
local initial
local handleButtonEvent
local moveBack
local move
--=======================================================================================
--宣告與定義main()函式
--=======================================================================================
local main = function (  )
	initial()
end

--=======================================================================================
--定義其他函式
--=======================================================================================
initial = function (  )
	img = display.newImageRect(  "images/horse-0.gif", 150, 135 )
  	img.x = orign_x
  	img.y = _SCREEN.CENTER.Y  - 100
  	img.alpha = origin_alpha
    btn_play = widget.newButton{
    	id = "play",
    	width = 600,
	    height = 150,
	    defaultFile = "images/btn_normal.png",
	    overFile = "images/btn_over.png",
	    label = "播放",
	    fontSize = 80,
	    onEvent = handleButtonEvent
	}
	btn_play.x = _SCREEN.CENTER.X
	btn_play.y = _SCREEN.CENTER.Y + 100

	btn_stop = widget.newButton{
    	id = "stop",
    	width = 600,
	    height = 150,
	    defaultFile = "images/btn_normal.png",
	    overFile = "images/btn_over.png",
	    label = "停止",
	    fontSize = 80,
	    onEvent = handleButtonEvent
	}
	btn_stop.x = _SCREEN.CENTER.X
	btn_stop.y = _SCREEN.CENTER.Y + 300
end

--用於onComplete事件發生時所要被呼叫的function
moveBack = function (  )
	--執行移動動畫，參數依序為目標物件以及option table，裡頭option中較特別的為transition屬性用於設定移動效果，onComplete用於設定當結束後要呼叫的function
	transitionBack = transition.to( img, {time = 3000 , x = orign_x , xScale = 1 , yScale = 1 , rotation = 0 , alpha = origin_alpha , transition = easing.outBounce ,onComplete = move} )
end
move = function ()
	transitionGo = transition.to( img, {time = 2000 , x = 30 , xScale = 1.4 , yScale = 1.4 , rotation = 0 , alpha = 1 , transition = easing.inQuad , onComplete = moveBack} )
end

handleButtonEvent = function ( event )
	if ("play" == event.target.id) then
		move()
	elseif ( "stop" == event.target.id) then
		--暫停所有動畫
		transition.pause()
	end
end
--=======================================================================================
--呼叫主函式
--=======================================================================================
main()
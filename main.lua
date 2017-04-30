display.setStatusBar(display.HiddenStatusBar)

local flagFlash = false
local flagDisp = false
local flagPulso = false

local flagFlashTemp = false
local flagDispTemp = false
local flagPulsoTemp = false

local widget = require('widget')
local flashlight = require('plugin.flashlight')

-- disable (turn off) the idle timer
system.setIdleTimer( false )  


     -- Corona Ads
     --
     local coronaAds = require( "plugin.coronaAds" )
     -- Substitute your own placement IDs when generated
     local bannerPlacement = "top-banner-320x50"
     local interstitialPlacement = "interstitial-1"

     -- Corona Ads listener function
     local function adListener( event )

         -- Successful initialization of Corona Ads
         if ( event.phase == "init" ) then
           -- Show an ad
           coronaAds.show( bannerPlacement, false )
           --coronaAds.show( interstitialPlacement, true )
         end
     end

-- Function to handle button events
local function handleButtonEvent( event )
	local phase = event.phase
    
	if "began" == phase then 
		print( "Button was pressed ")
		flashlight.on()
	end
	
	if "ended" == phase then 
        print( "Button was released" )
		flashlight.off()
    end
	
end


--display.setDefault('background', 1)
display.setDefault('fillColor', 1, 1, 1)

local proporcaoTela = 0.2
local x, y = display.contentCenterX, display.contentCenterY
local w, h = display.contentWidth * proporcaoTela * 2,  display.contentHeight * proporcaoTela / 2
local larg, alt = display.contentWidth, display.contentHeight

local posBtX = {x, x, x}
local posBtY = {y-75, y, y+75}


--print( "x= " .. x .. " y= " .. y .. " w= " .. w .. " h= " .. h )
--print( "Larg= " .. larg .. " Alt= " .. alt )

local btLant = widget.newButton{
    x = posBtX[1], y = posBtY[1],
    width = w, height = h,
    --label = 'Flashlight ON',
	defaultFile = "lant01off.png",
	overFile = "over.png",
    onRelease = function()
		flagFlash = not flagFlash  
		flagFlashTemp = flagFlash  
		--[[
		if ( flagFlash ) then
			flashlight.on()
			print("Flash ON")
		else
			flashlight.off()
			print("Flash OFF")
		end
		]]--
		
    end}

local btDisp = widget.newButton{
    x = posBtX[3], y = posBtY[3],
    width = w, height = h,
    --label = 'Flashlight OFF',
	defaultFile = "lant03off.png",
	overFile = "over.png",
    onRelease = function()
        flagDisp = not flagDisp  
        flagDispTemp = flagDisp  
		--[[
		if ( flagDisp ) then
			display.setDefault('background', 1)
			print("Disp ON")
		else
			display.setDefault('background', 0)
			print("Disp OFF")
		end
		]]--
    end}
	
local btPulso = widget.newButton{
    x = posBtX[2], y = posBtY[2],
    width = w, height = h,
    --label = 'Flashlight',
	defaultFile = "lant02.png",
	overFile = "over.png",
	 onRelease = function()
        flagPulso = not flagPulso
		--[[
		if ( flagPulso ) then
			print("PULSO ON")
		else
			print("PULSO OFF")
		end	
		]]--
    end}
--[[	
local btPulso = widget.newButton{
    x = x, y = y,
    width = w, height = h,
    label = 'Flashlight',
	defaultFile = "release_orange.png",
	overFile = "over.png",
	onEvent = function()
			display.setDefault('background', 1)
			print("Disp ON")
    end,
	onRelease = function()
			display.setDefault('background', 0)
			print("Disp OFF")
	end,
	
	}
]]--



local largura_quadrado = w
local altura_quadrado = h
local espaco_quadrado = 75

--IMAGE INICIO
local image01 = display.newImageRect( "lant01off.png", largura_quadrado, altura_quadrado )
local image02 = display.newImageRect( "lant02on.png", largura_quadrado, altura_quadrado )
local image03 = display.newImageRect( "lant03off.png", largura_quadrado, altura_quadrado )
local image04 = display.newImageRect( "lant01on.png", largura_quadrado, altura_quadrado )
local image05 = display.newImageRect( "lant02off.png", largura_quadrado, altura_quadrado )
local image06 = display.newImageRect( "lant03on.png", largura_quadrado, altura_quadrado )

local redSquares ={	image01, image02, image03, image04, image05, image06}
local scaleredSquares = 1
for i = 1, 3 do
		--local posy = ( (i - 1) * espaco_quadrado) + (espaco_quadrado / 2)
		--local posx =  espaco_quadrado + (espaco_quadrado / 2)
		--manipulate the square at the current index (i)
		redSquares[i].x = posBtX[i]
		redSquares[i].y = posBtY[i]
		redSquares[i]:scale( scaleredSquares, scaleredSquares )
		redSquares[i].isVisible = true

		redSquares[i+3].x = posBtX[i]
		redSquares[i+3].y = posBtY[i]
		redSquares[i+3]:scale( scaleredSquares, scaleredSquares )
		redSquares[i+3].isVisible = true
end

	--TIMER LISTENER

local listener = {}

function listener:timer( event )
		if ( flagPulso ) then
		
		flagPulsoTemp = not flagPulsoTemp
		
		--print("PULSO ON")

			if ( flagDisp ) then
				if ( flagDispTemp ) then
					display.setDefault('background', 1)
					redSquares[3].isVisible = false
					redSquares[6].isVisible = true
				else
					display.setDefault('background', 0)
					redSquares[3].isVisible = true
					redSquares[6].isVisible = false
				end
			flagDispTemp = not flagDispTemp
				
			else
					display.setDefault('background', 0)
					redSquares[3].isVisible = true
					redSquares[6].isVisible = false			
			end
			
			if ( flagFlash ) then
			if ( flagFlashTemp ) then
				flashlight.on()
					redSquares[1].isVisible = false
					redSquares[4].isVisible = true
			else
				flashlight.off()
					redSquares[1].isVisible = true
					redSquares[4].isVisible = false
			end
			flagFlashTemp = not flagFlashTemp

			else
				flashlight.off()
					redSquares[1].isVisible = true
					redSquares[4].isVisible = false
			
			end

					--redSquares[2].isVisible = false
					--redSquares[5].isVisible = true
		else
			flagPulsoTemp = false
		
			--SE PULSO == FALSE
			if ( flagDisp ) then
					display.setDefault('background', 1)
					redSquares[3].isVisible = false
					redSquares[6].isVisible = true
			else
					display.setDefault('background', 0)
					redSquares[3].isVisible = true
					redSquares[6].isVisible = false
					
			end
			
			if ( flagFlash ) then
				flashlight.on()
					redSquares[1].isVisible = false
					redSquares[4].isVisible = true
			else
				flashlight.off()
					redSquares[1].isVisible = true
					redSquares[4].isVisible = false
			end

			--redSquares[2].isVisible = true
			--redSquares[5].isVisible = false
		end		

		if ( flagPulsoTemp ) then
			redSquares[2].isVisible = false
			redSquares[5].isVisible = true
			else
			redSquares[2].isVisible = true
			redSquares[5].isVisible = false
			
		end
		
		if ( (flagDisp == false) and (flagFlash  == false) ) then
					flagPulso = false
			end
end

--APAGA O FLASH ANTES DE SAIR !!!
local function onSystemEvent( event )
   if ( event.type == "applicationSuspend" ) then
      flashlight.off()
	  flagPulso = false
	  flagDisp = false
	  flagFlash  = false  
   end
end

--EVENTO PARA DESLIGAR A LANTERNA NA SAIDA DO APLICATIVO
Runtime:addEventListener( "system", onSystemEvent )

--EVENTO DE MONITORAMENTO E CONTROLE
timer.performWithDelay( 500, listener , 0)
	
 -- Initialize Corona Ads (substitute your own API key when generated)
coronaAds.init( "c5324128-8360-4280-89c6-64988bbf3d0b", adListener )
  
  
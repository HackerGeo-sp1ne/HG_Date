--[[
    FiveM Scripts
    The Official HackerGeo Script 
	WEBISTE: www.HackerGeo.com
	GITHUB: GITHUB.com/HackerGeo-sp1ne
	STEAM: SteamCommunity.com/id/HackerGeo1

]]

--------------------------------------------------------------------------------------------------------------------
------------------------------------------- Inspired Scripts by HackerGeo ------------------------------------------
--------------------------------------------------------------------------------------------------------------------


local ServerSlots = 32
local Hours = 0 -- time

local displayTime = true
local displayDate = true

local timeAndDateString = nil

function CalculateDayOfWeekToDisplay()
	if dayOfWeek == 1 then
		dayOfWeek = "Duminica"
	elseif dayOfWeek == 2 then
		dayOfWeek = "Luni"
	elseif dayOfWeek == 3 then
		dayOfWeek = "Marti"
	elseif dayOfWeek == 4 then
		dayOfWeek = "Miercuri"
	elseif dayOfWeek == 5 then
		dayOfWeek = "Joi"
	elseif dayOfWeek == 6 then
		dayOfWeek = "Vineri"
	elseif dayOfWeek == 7 then
		dayOfWeek = "Sambata"
	end
end

function CalculateDateToDisplay()
	if month == 1 then
		month = "1"
	elseif month == 2 then
		month = "2"
	elseif month == 3 then
		month = "3"
	elseif month == 4 then
		month = "4"
	elseif month == 5 then
		month = "5"
	elseif month == 6 then
		month = "6"
	elseif month == 7 then
		month = "7"
	elseif month == 8 then
		month = "8"
	elseif month == 9 then
		month = "9"
	elseif month == 10 then
		month = "10"
	elseif month == 11 then
		month = "11"
	elseif month == 12 then
		month = "12"
	end
end

function CalculateTimeToDisplay()
	if hour <= 9 then
		hour = tonumber("0" .. hour)
	end
	if minute <= 9 then
		minute = tonumber("0" .. minute)
	end
end

local function RGBRainbow( frequency )
	local result = {}
	local curtime = GetGameTimer() / 1000

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end

AddEventHandler("playerSpawned", function()	
	Citizen.CreateThread(function()
		while true do
            Wait(1)
            pPed = GetPlayerPed(-1)
            hp = GetEntityHealth(pPed)
    			year, month, dayOfWeek, hour, minute = GetLocalTime()
			hour = hour + Hours
			timeAndDateString = "~w~["
			CalculateTimeToDisplay()
			if displayTime == true then
				timeAndDateString = timeAndDateString .. "~s~ONLINE ".. GetActivePlayers .."/".. ServerSlots .."~w~]"
			end
			if displayDate == true then
				CalculateDateToDisplay()
				timeAndDateString = timeAndDateString .. " " .. dayOfWeek .. "~s~/~w~" .. month .. "~s~/~w~" .. year .. " ~y~| ~s~" .. hour .. ":" .. minute .. ""
			end
			
			SetTextFont(4)
			SetTextProportional(1)
            SetTextScale(0.49, 0.49)
            local rainbow = RGBRainbow( 1 )
			SetTextColour(rainbow.r, rainbow.g, rainbow.b, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextRightJustify(true)
			SetTextWrap(0,0.95)
			SetTextEntry("STRING")
			
			AddTextComponentString(timeAndDateString)
			DrawText(0.5, 0.01)
		end
	end)
end)

local fuelkontrolle = 1
local strStart = "go"

local walkKontrolle = 1

print("Treibstoff in den ersten Slot und Fackeln in den Slot rechts davon legen.")
print("Wenn der Treibstoff eingenommen wurde, 'go' eingeben")
while fuelkontrolle == 1 do
	turtle.select(1)
	turtle.refuel()

	if turtle.getFuelLevel()~=0 then
		local strEingabe = read()
		if strEingabe==strStart then
			fuelkontrolle = 2

		else

		end

	end
end
print("Wie lang soll der Tunnel sein?")
print("")
local numLaenge = tonumber(read())
print("Wie lang sollen die seitlichen Tunnel sein?")
print("")
local numLaengeSeitlich = tonumber(read())

local function digOneForward()
	while turtle.detectUp()==true do
		turtle.digUp()
	end
	while turtle.detect()==true do

		turtle.dig()

	end
	turtle.forward()
	while turtle.detectUp()==true do
		turtle.digUp()
	end
end

local function moveForward()
	if turtle.detect()==false then
		turtle.forward()
	else
		digOneForward()
	end
	if turtle.detectUp()==true then
		turtle.digUp()
	end
end

local function placeTorchOnBlock()
	turtle.placeDown()
	moveForward()
	turtle.turnLeft()
	turtle.turnLeft()
	turtle.select(2)
	turtle.place()
	turtle.turnLeft()
	turtle.turnLeft()
end

local function placeTorch()
	turtle.select(2)
	local dataSlot = turtle.getItemDetail()
	local r = 1
	if turtle.getItemCount()~=0 then
		if dataSlot.name == "minecraft:torch" then
			if turtle.detectDown()==false then

				while r~=17 do
					turtle.select(r)
					if turtle.getItemCount()~=0 then
						local findBlock = turtle.getItemDetail()

						if findBlock.name == "minecraft:cobblestone" then
							placeTorchOnBlock()
							r=16
						end
						r=r+1
					end
				end
			else
			placeTorchOnBlock()
			end
			
		end
	end
	turtle.select(1)
end
for i=1,numLaenge do
	if walkKontrolle==1 then
		moveForward()
		moveForward()
	else
		moveForward()
    end
		turtle.turnLeft()
    for j=1,numLaengeSeitlich do
        moveForward()
    end
        turtle.turnRight()
        turtle.turnRight()
    for k=1,numLaengeSeitlich*2 do
        moveForward()
    end
        turtle.turnLeft()
        turtle.turnLeft()
    for l=1,numLaengeSeitlich do
        turtle.forward()
    end
	turtle.turnRight()
	if i%2==0 then
		placeTorch()
		walkKontrolle = 2
	else
		walkKontrolle = 1
	end
	
   
end
print(turtle.getFuelLevel(),"Treibstoff verbleibend.")

channels = {}
channels["GL"] = {}
channelDescription = {}
channelDescription["GL"] = "Global channel, for international chat. Everyone is here by default"
--function onStart(

function onChat(message, messageType)
	if(messageType == 0) then
		cancelEvent()
		local x,y,z = getElementPosition(source)
		local chatSphere = createColSphere(x,y,z,100)
		local players = getElementsWithinColShape(chatSphere, "player")
		local name = getPlayerName(source)
		for i,player in ipairs(players) do
			outputChatBox(name .. ": " .. message, player, 153, 153, 0)
		end
	end
end
addEventHandler("onPlayerChat", getRootElement(), onChat)

function joinChannel(player, commandName, channelName)
	if(channels[channelName] ~= nil) then
		if(channels[channelName] == false) then
			channels[channelName][player] = true
			outputChatBox("You have been successfully added to " .. channelName .. " channel!", getRootElement(), 153, 0, 0)
		else
			outputChatBox("You are already part of " .. channelName .. " channel!", getRootElement(), 153, 0, 0)
		end
	else
		outputChatBox("The channel you have attempted to join (" .. channelName .. ") doesn't exist!", getRootElement(), 153, 0, 0)
	end
end
addCommandHandler("jc", joinChannel)
addCommandHandler("joinchannel", joinChannel)

function leaveChannel(player, commandName, channelName)
	if(channels[channelName] ~= nil) then
		if(channels[channelName][player] == true) then
			channels[channelName][player] = false
			outputChatBox("You have been successfully removed from " .. channelName .. " channel!", getRootElement(), 153, 0, 0)
		else
			outputChatBox("You are not part of " .. channelName .. ", therefore you cannot leave it!", getRootElement(), 153, 0, 0)
		end
	else
		outputChatBox("The channel you have attempted to leave (" .. channelName .. ") doesn't exist!", getRootElement(), 153, 0, 0)
	end
end
addCommandHandler("lc", leaveChannel)
addCommandHandler("leavechannel", leaveChannel)

function createChannel(player, commandName, channelName, channelDesc)
	if(channels[channelName] == nil) then
		channels[channelName] = {}
		channels[channelName][player] = true
		channelDescription[channelName] = channelDesc
		outputChatBox("You have successfully created " .. channelName .. " channel!", getRootElement(), 153, 0, 0)
	else
		outputChatBox("The channel you have attempted to create (" .. channelName .. ") already exists!", getRootElement(), 153, 0, 0)
	end
end
addCommandHandler("cc", createChannel)
addCommandHandler("createchannel", createChannel)

function listChannels(player, commandName)
	for channelName,channelDesc in pairs(channelDescription) do
		outputChatBox("[" .. channelName .. "]: " .. channelDesc, player, 153, 0, 0)
	end
end
addCommandHandler("lc", listChannels)
addCommandHandler("listchannels", listChannels)
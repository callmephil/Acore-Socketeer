-- Credits: (WiFiHaxR) https://ac-web.org/threads/eluna-ac-socketeer.177340/post-2006642

local SocketEnchant = 37430 -- Item ID
local RequiredMoney = 100000 -- Example required money amount in copper (10g)
local StatBonus = 10 -- Example stat bonus
local StatCost = 50000 -- Example stat cost in copper (5g)

local function OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(0, "|TInterface\\Icons\\inv_misc_gem_variety_01:50:50:-43:0|tPurchase gem sockets for your gear?", 0, 1)
    player:GossipMenuAddItem(0, "|TInterface\\Icons\\ability_warrior_savageblow:50:50:-43:0|tPurchase a stat bonus for your gear?", 0, 100)
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code, menuid)
    if (intid == 1) then
        local requiredMoney = RequiredMoney
        player:SendBroadcastMessage("Exchanging " .. requiredMoney / 100 / 100 .. " gold for a socket enchant. Are you sure?")
        player:GossipMenuAddItem(0, "Yes", 0, 2)
        player:GossipMenuAddItem(0, "No", 0, 3)
        player:GossipSendMenu(1, creature)
    elseif (intid == 2) then
        if (player:GetCoinage() >= RequiredMoney) then
            player:SetCoinage(player:GetCoinage() - RequiredMoney)
            player:AddItem(SocketEnchant, 1)
            player:SendBroadcastMessage("The socket enchant has been added to your inventory.")
            player:GossipComplete()
        else
            player:SendBroadcastMessage("You do not have enough money.")
            player:GossipComplete()
        end
    elseif (intid == 3) then
        player:GossipComplete()
    elseif (intid == 100) then
        player:SendBroadcastMessage("Select the stat you would like to increase by " .. StatBonus .. " for " .. StatCost / 100 / 100 .. " gold:")
        player:GossipMenuAddItem(0, "Strength", 0, 101)
        player:GossipMenuAddItem(0, "Agility", 0, 102)
        player:GossipMenuAddItem(0, "Stamina", 0, 103)
        player:GossipMenuAddItem(0, "Intellect", 0, 104)
        player:GossipMenuAddItem(0, "Spirit", 0, 105)
        player:GossipSendMenu(1, creature)
    elseif (intid >= 101 and intid <= 105) then
        if (player:GetCoinage() >= StatCost) then
            player:SetCoinage(player:GetCoinage() - StatCost)
            -- Apply the stat bonus to the player's gear
            player:SendBroadcastMessage("Your stat has been increased by " .. StatBonus .. ".")
            player:GossipComplete()
        else
            player:SendBroadcastMessage("You do not have enough money.")
            player:GossipComplete()
        end
    end
end

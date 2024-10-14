local function FindTooltipLine(tooltip, lineIndex)
    for i = 1, tooltip:NumLines() do
        local line = _G[tooltip:GetName() .. "TextLeft" .. i]
        if i == lineIndex then
            return line
        end
    end
    return nil
end

-- Edit here
local itemLevelFlags = {
    [1] = 290, -- T11
    [2] = 300, -- Artifact 1
    [3] = 310, -- T12
    [4] = 330, -- T13
    [5] = 340, -- Artifact 2
    [6] = 350, -- T14
    [7] = 380, -- T15
    [8] = 390, -- Artifact 3
    [9] = 400, -- T16

}

local flagTexts = {
    [1] = "|cff00FF00Tier 11",
    [2] = "|cffe74c3cArtifact",
	[3] = "|cff00FF00Tier 12",
	[4] = "|cff00FF00Tier 13",
	[5] = "|cffe74c3cArtifact 2",
	[6] = "|cff00FF00Tier 14",
	[7] = "|cff00FF00Tier 15",
	[8] = "|cffe74c3cArtifact 3",
	[9] = "|cff00FF00Tier 16",
}

local function GetFlagByItemLevel(itemLevel)
    if itemLevel == itemLevelFlags[1] then
        return 1
    elseif itemLevel == itemLevelFlags[2] then
        return 2
	 elseif itemLEvel == itemLevelFlags[3] then
		return 3
	 elseif itemLEvel == itemLevelFlags[3] then
		return 4
	 elseif itemLEvel == itemLevelFlags[3] then
		return 5
	 elseif itemLEvel == itemLevelFlags[3] then
		return 6
	 elseif itemLEvel == itemLevelFlags[3] then
		return 7
	 elseif itemLEvel == itemLevelFlags[3] then
		return 8
	 elseif itemLEvel == itemLevelFlags[3] then
		return 9		
	-- elseif itemLEvel == itemLevelFlags[3] then
	-- return 3 	
    end
    return nil  -- Default
end

-- Do not edit
local function AddTooltipLine(tooltip)
    local itemName, ItemLink = tooltip:GetItem()
    if ItemLink then
        local itemName, itemLink, itemQuality, itemLevel, itemMinLevel, itemType, itemSubType,
              itemStackCount, itemEquipLoc, itemTexture, sellPrice, classID, subclassID, bindType,
              expacID, setID, isCraftingReagent = GetItemInfo(ItemLink)
        
		-- Only Armor or Weapons
        if itemType == 'Armor' or itemType == 'Weapon' then
            local flag = GetFlagByItemLevel(itemLevel)
            
            if flag then
                local lineText = flagTexts[flag]
                local line = FindTooltipLine(tooltip, 2)
                if line then
                    line:SetText(lineText)
                end
            end
        end
    end
end

GameTooltip:HookScript("OnTooltipSetItem", function(self)
    AddTooltipLine(self)
end)

ItemRefTooltip:HookScript("OnTooltipSetItem", function(tooltip, ...)
    AddTooltipLine(tooltip)
end)

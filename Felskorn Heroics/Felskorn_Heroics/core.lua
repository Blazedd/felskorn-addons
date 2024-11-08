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
    [1] = 66, -- T1
    [2] = 76, -- T2
    [3] = 86, -- T3
    [4] = 88, -- T3
    [5] = 92, -- T3
    [6] = 120, -- T4
    [7] = 133, -- T5
    [8] = 146, -- T6
    [9] = 154, -- T6
    [10] = 200, -- T7
    [11] = 213, -- T7.5
    [12] = 219, -- T8
    [13] = 226, -- T8.5
    [14] = 232, -- T9
    [15] = 245, -- T9.5
    [16] = 258, -- T9 HC
    [17] = 251, -- T10
    [18] = 264, -- T10.5
    [19] = 277, -- T10hc
    [20] = 290, -- T11(Custom)
    [21] = 300, -- Artifact(Custom)
    [22] = 310, -- T12(Custom)
    [23] = 330, -- T13(Custom)
    [24] = 340, -- Artifact 2(Custom)
    [25] = 350, -- T14(Custom)
    [26] = 380, -- T15(Custom)
    [27] = 390, -- Artifact 3(Custom)
    [28] = 400, -- T16(Custom)
}

local flagTexts = {
    [1] = "|cff00FF00Tier 1", -- T1
    [2] = "|cff00FF00Tier 2", -- T2
    [3] = "|cff00FF00Tier 3", -- T3
    [4] = "|cff00FF00Tier 3", -- T3
    [5] = "|cff00FF00Tier 3", -- T3
    [6] = "|cff00FF00Tier 4", -- T4
    [7] = "|cff00FF00Tier 5", -- T5
    [8] = "|cff00FF00Tier 6", -- T6
    [9] = "|cff00FF00Tier 6", -- T6
    [10] = "|cff00FF00Tier 7", -- T7
    [11] = "|cff00FF00Tier 7.5", -- T7.5
    [12] = "|cff00FF00Tier 8", -- T8
    [13] = "|cff00FF00Tier 8.5", -- T8.5
    [14] = "|cff00FF00Tier 9", -- T9
    [15] = "|cff00FF00Tier 9.5", -- T9.5
    [16] = "|cff00FF00Tier 9 Heroic", -- T9 HC
    [17] = "|cff00FF00Tier 10", -- T10
    [18] = "|cff00FF00Tier 10.5", -- T10.5
    [19] = "|cff00FF00Tier 10 Heroic", -- T10hc
    [20] = "|cff00FF00Tier 11", -- Custom
    [21] = "|cffe74c3cArtifact", -- Custom
	[22] = "|cff00FF00Tier 12", -- Custom
	[23] = "|cff00FF00Tier 13", -- Custom
	[24] = "|cffe74c3cArtifact 2", -- Custom
	[25] = "|cff00FF00Tier 14", -- Custom
	[26] = "|cff00FF00Tier 15", -- Custom
	[27] = "|cffe74c3cArtifact 3", -- Custom
	[28] = "|cff00FF00Tier 16", -- Custom
}

local function GetFlagByitemLevel(itemLevel)
    if itemLevel == itemLevelFlags[1] then
        return 1
    elseif itemLevel == itemLevelFlags[2] then
        return 2
	 elseif itemLevel == itemLevelFlags[3] then
		return 3
	 elseif itemLevel == itemLevelFlags[4] then
		return 4
	 elseif itemLevel == itemLevelFlags[5] then
		return 5
	 elseif itemLevel == itemLevelFlags[6] then
		return 6
	 elseif itemLevel == itemLevelFlags[7] then
		return 7
	 elseif itemLevel == itemLevelFlags[8] then
		return 8
	 elseif itemLevel == itemLevelFlags[9] then
		return 9
	 elseif itemLevel == itemLevelFlags[10] then
		return 10
	 elseif itemLevel == itemLevelFlags[11] then
		return 11
	 elseif itemLevel == itemLevelFlags[12] then
		return 12
	 elseif itemLevel == itemLevelFlags[13] then
		return 13
	 elseif itemLevel == itemLevelFlags[14] then
		return 14
	 elseif itemLevel == itemLevelFlags[15] then
		return 15
	 elseif itemLevel == itemLevelFlags[16] then
		return 16
	 elseif itemLevel == itemLevelFlags[17] then
		return 17
	 elseif itemLevel == itemLevelFlags[18] then
		return 18
	 elseif itemLevel == itemLevelFlags[19] then
		return 19
	 elseif itemLevel == itemLevelFlags[20] then
		return 20
	 elseif itemLevel == itemLevelFlags[21] then
		return 21
	 elseif itemLevel == itemLevelFlags[22] then
		return 22
	 elseif itemLevel == itemLevelFlags[23] then
		return 23
	 elseif itemLevel == itemLevelFlags[24] then
		return 24
	 elseif itemLevel == itemLevelFlags[25] then
		return 25
	 elseif itemLevel == itemLevelFlags[26] then
		return 26
	 elseif itemLevel == itemLevelFlags[27] then
		return 27
	 elseif itemLevel == itemLevelFlags[28] then
		return 28
		
	-- elseif itemLevel == itemLevelFlags[3] then
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
            local flag = GetFlagByitemLevel(itemLevel)
            
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

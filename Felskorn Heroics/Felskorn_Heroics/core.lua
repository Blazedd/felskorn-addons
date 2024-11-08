----------------------------
-- This addon is created for Felskorn. 
-- It modifies the default green "Heroic" text based on ItemLevel. 
-- It replaces with the appropriate tier text and color as defined in itemLevelTierMapping.
----------------------------

--- Edit here: ItemLevel | Text shown.
local itemLevelsAndTexts = {
    [66] = "|cff00FF00Tier 1|r",
    [76] = "|cff00FF00Tier 2|r",
    [86] = "|cff00FF00Tier 3|r",
    [88] = "|cff00FF00Tier 3|r",
    [92] = "|cff00FF00Tier 3|r",
    [120] = "|cff00FF00Tier 4|r",
    [133] = "|cff00FF00Tier 5|r",
    [146] = "|cff00FF00Tier 6|r",
    [154] = "|cff00FF00Tier 6|r",
    [200] = "|cff00FF00Tier 7|r",
    [213] = "|cff00FF00Tier 7.5|r",
    [219] = "|cff00FF00Tier 8|r",
    [226] = "|cff00FF00Tier 8.5|r",
    [232] = "|cff00FF00Tier 9|r",
    [245] = "|cff00FF00Tier 9.5|r",
    [258] = "|cff00FF00Tier 9 Heroic|r",
    [251] = "|cff00FF00Tier 10|r",
    [264] = "|cff00FF00Tier 10.5|r",
    [277] = "|cff00FF00Tier 10 Heroic|r",
    [290] = "|cff00FF00Tier 11|r",
    [300] = "|cffe74c3cArtifact|r",
    [310] = "|cff00FF00Tier 12|r",
    [330] = "|cff00FF00Tier 13|r",
    [340] = "|cffe74c3cArtifact 2|r",
    [350] = "|cff00FF00Tier 14|r",
    [380] = "|cff00FF00Tier 15|r",
    [390] = "|cffe74c3cArtifact 3|r",
    [400] = "|cff00FF00Tier 16|r"
}

--- Only make edits below if you're familiar with the code.
local function GetTextByItemLevel(itemLevel)
    return itemLevelsAndTexts[itemLevel]
end

local function AddTooltipLine(tooltip)
    local itemName, itemLink, _, itemLevel, _, itemType = GetItemInfo(tooltip:GetItem())
    if itemLink and (itemType == 'Armor' or itemType == 'Weapon') then
        local lineText = GetTextByItemLevel(itemLevel)
        if lineText then
            local line = _G[tooltip:GetName() .. "TextLeft2"]
            if line then
                line:SetText(lineText)
            end
        end
    end
end

local function FindAndReplaceHeroicText(tooltip)
    for i = 1, tooltip:NumLines() do
        local leftLine = _G[tooltip:GetName() .. "TextLeft" .. i]
        if leftLine and leftLine:GetText() == "Heroic" then
            local _, _, _, itemLevel = GetItemInfo(tooltip:GetItem())
            local lineText = GetTextByItemLevel(itemLevel)
            if lineText then
                leftLine:SetText(lineText)
                tooltip:Show()
                break
            end
        end
    end
end

local function ShowCompareItemTooltip(link)
    local tooltips = {ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3}
    for i, tooltip in ipairs(tooltips) do
        tooltip:SetOwner(GameTooltip, "ANCHOR_NONE")
        tooltip:ClearLines()
        if tooltip:SetHyperlinkCompareItem(link, i, 1, GameTooltip) then
            FindAndReplaceHeroicText(tooltip)
        end
    end

    local left, right, anchor1, anchor2 = GameTooltip:GetLeft(), GameTooltip:GetRight(), "TOPLEFT", "TOPRIGHT"
    if not left or not right then return end
    if (GetScreenWidth() - right) < left then anchor1, anchor2 = anchor2, anchor1 end

    tooltips[1]:ClearAllPoints()
    tooltips[1]:SetPoint(anchor1, GameTooltip, anchor2, 0, -10)
    tooltips[1]:Show()

    for i = 2, #tooltips do
        if tooltips[i]:NumLines() > 0 then
            tooltips[i]:ClearAllPoints()
            tooltips[i]:SetPoint(anchor1, tooltips[i - 1], anchor2)
            tooltips[i]:Show()
        end
    end
end

GameTooltip:HookScript("OnTooltipSetItem", function(self)
    AddTooltipLine(self)
end)

ItemRefTooltip:HookScript("OnTooltipSetItem", function(tooltip)
    AddTooltipLine(tooltip)
end)

GameTooltip:HookScript("OnTooltipSetItem", function(self)
    local _, link = self:GetItem()
    if link and IsShiftKeyDown() then
        ShowCompareItemTooltip(link)
    end
end)

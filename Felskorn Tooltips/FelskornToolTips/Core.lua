local Sets = {};
local origTooltips = {};

local function RegisterSet(name, ...)
	for _, v in ipairs({...}) do
		Sets[v] = name;
	end
end

local function SetupSets()

--	RegisterSet("TEXT", ID,ID,ID);

	RegisterSet("Tier 5", 304307,304306,304305,304304,304303,304302,304301,304300,304299,304298,304297,304296,304295,304294,304293,304292,304291,304290,304289,304288,304287,304286,304285,304284,304283,304282,304281,304280);
	RegisterSet("Tier 4", 303307,303306,303305,303304,303303,303302,303301,303300,303299,303298,303297,303296,303295,303294,303293,303292,303291,303290,303289,303288,303287,303286,303285,303284,303283,303282,303281,303280);

end

local function GetIDFromLink(link)
	if link == nil then return 0; end
	local id = string.match(link, "item:(%d+)");
	return tonumber(id);
end

local function OnTooltipSetItemHook(tooltip, ...)
	local itemName, itemLink = tooltip:GetItem();
	local itemID = GetIDFromLink(itemLink);
	if (itemID and Sets[itemID]) then
		tooltip:AddLine("Source: "..Sets[itemID], 1, 1, 0);
	end
	if origTooltips[this] then
		return origTooltips[this](tooltip, ...);
	end
end

SetupSets();

local hookTooltips = {};
hookTooltips[GameTooltip] = 1; -- mouseover
hookTooltips[ItemRefTooltip] = 1; -- clicked
if (AtlasLootTooltip) then hookTooltips[AtlasLootTooltip] = 1; end

for tt in pairs(hookTooltips) do
	local origHook = tt:GetScript("OnTooltipSetItem");
	if (origHook ~= OnTooltipSetItemHook) then
		origTooltips[tt] = origHook;
		tt:SetScript("OnTooltipSetItem", OnTooltipSetItemHook);
	end
end

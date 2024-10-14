AllStatsShowFrame = true;

function AllStats_OnLoad(self)
	CharacterAttributesFrame:Hide();
	CharacterModelFrame:SetHeight(300);
	PaperDollFrame_UpdateStats = NewPaperDollFrame_UpdateStats;
end

function NewPaperDollFrame_UpdateStats()
	PrintStats();
end

function PrintStats()
	local str = AllStatsFrameStat1;
	local agi = AllStatsFrameStat2;
	local sta = AllStatsFrameStat3;
	local int = AllStatsFrameStat4;
	local spi = AllStatsFrameStat5;

	local md = AllStatsFrameStatMeleeDamage;
	local ms = AllStatsFrameStatMeleeSpeed;
	local mp = AllStatsFrameStatMeleePower;
	local mh = AllStatsFrameStatMeleeHit;
	local mc = AllStatsFrameStatMeleeCrit;
	local me = AllStatsFrameStatMeleeExpert;

	local rd = AllStatsFrameStatRangeDamage;
	local rs = AllStatsFrameStatRangeSpeed;
	local rp = AllStatsFrameStatRangePower;
	local rh = AllStatsFrameStatRangeHit;
	local rc = AllStatsFrameStatRangeCrit;

	local sd = AllStatsFrameStatSpellDamage;
	local she = AllStatsFrameStatSpellHeal;
	local shi = AllStatsFrameStatSpellHit;
	local sc = AllStatsFrameStatSpellCrit;
	local sha = AllStatsFrameStatSpellHaste;
	local sr = AllStatsFrameStatSpellRegen;

	local armor = AllStatsFrameStatArmor;
	local def = AllStatsFrameStatDefense;
	local dodge = AllStatsFrameStatDodge;
	local parry = AllStatsFrameStatParry;
	local block = AllStatsFrameStatBlock;
	local res = AllStatsFrameStatResil;


	PaperDollFrame_SetStat(str, 1);
	PaperDollFrame_SetStat(agi, 2);
	PaperDollFrame_SetStat(sta, 3);
	PaperDollFrame_SetStat(int, 4);
	PaperDollFrame_SetStat(spi, 5);

	PaperDollFrame_SetDamage(md);
	md:SetScript("OnEnter", CharacterDamageFrame_OnEnter);
	PaperDollFrame_SetAttackSpeed(ms);
	PaperDollFrame_SetAttackPower(mp);
	PaperDollFrame_SetRating(mh, CR_HIT_MELEE);
	PaperDollFrame_SetMeleeCritChance(mc);
	PaperDollFrame_SetExpertise(me);

	PaperDollFrame_SetRangedDamage(rd);
	rd:SetScript("OnEnter", CharacterRangedDamageFrame_OnEnter);
	PaperDollFrame_SetRangedAttackSpeed(rs);
	PaperDollFrame_SetRangedAttackPower(rp);
	PaperDollFrame_SetRating(rh, CR_HIT_RANGED);
	PaperDollFrame_SetRangedCritChance(rc);

	PaperDollFrame_SetSpellBonusDamage(sd);
	sd:SetScript("OnEnter", CharacterSpellBonusDamage_OnEnter);
	PaperDollFrame_SetSpellBonusHealing(she);
	PaperDollFrame_SetRating(shi, CR_HIT_SPELL);
	PaperDollFrame_SetSpellCritChance(sc);
	sc:SetScript("OnEnter", CharacterSpellCritChance_OnEnter);
	PaperDollFrame_SetSpellHaste(sha);
	PaperDollFrame_SetManaRegen(sr);

	PaperDollFrame_SetArmor(armor);
	PaperDollFrame_SetDefense(def);
	PaperDollFrame_SetDodge(dodge);
	PaperDollFrame_SetParry(parry);
	PaperDollFrame_SetBlock(block);
	PaperDollFrame_SetResilience(res);
	
	-- base
	str:SetPoint("RIGHT", -10, 0);
	agi:SetPoint("RIGHT", -10, 0);
	sta:SetPoint("RIGHT", -10, 0);
	int:SetPoint("RIGHT", -10, 0);
	spi:SetPoint("RIGHT", -10, 0);
	
	-- melee
	md:SetPoint("RIGHT", -10, 0);
	ms:SetPoint("RIGHT", -10, 0);
	mp:SetPoint("RIGHT", -10, 0);
	mh:SetPoint("RIGHT", -10, 0);
	mc:SetPoint("RIGHT", -10, 0);
	me:SetPoint("RIGHT", -10, 0);
	
	-- ranged
	rd:SetPoint("RIGHT", -10, 0);
	rs:SetPoint("RIGHT", -10, 0);
	rp:SetPoint("RIGHT", -10, 0);
	rh:SetPoint("RIGHT", -10, 0);
	rc:SetPoint("RIGHT", -10, 0);
	
	-- Spell
	sd:SetPoint("RIGHT", -10, 0);
	she:SetPoint("RIGHT", -10, 0);
	shi:SetPoint("RIGHT", -10, 0);
	sc:SetPoint("RIGHT", -10, 0);
	sha:SetPoint("RIGHT", -10, 0);
	sr:SetPoint("RIGHT", -10, 0);
	
	-- Dev
	armor:SetPoint("RIGHT", -10, 0);
	def:SetPoint("RIGHT", -10, 0);
	dodge:SetPoint("RIGHT", -10, 0);
	parry:SetPoint("RIGHT", -10, 0);
	block:SetPoint("RIGHT", -10, 0);
	res:SetPoint("RIGHT", -10, 0);
end

-- local AllStatsShowFrame = true;

function CharacterFrame_Collapse()
 --[[
	CharacterFrame:SetWidth(PANEL_DEFAULT_WIDTH);
	CharacterFrame.Expanded = false;
	--]]
	AllStatsShowFrame = false;
	CharacterFrameExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
	CharacterFrameExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
	CharacterFrameExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");
	
	AllStatsFrame:Hide();
end

function CharacterFrame_Expand()
	AllStatsFrame:Show();
	AllStatsShowFrame = true;
	CharacterFrameExpandButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
	CharacterFrameExpandButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
	CharacterFrameExpandButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
	--[[
	CharacterFrame:SetWidth(CHARACTERFRAME_EXPANDED_WIDTH);
	CharacterFrame.Expanded = true;
	if (PaperDollFrame:IsShown() and PaperDollFrame.currentSideBar) then
		PaperDollFrame.currentSideBar:Show();
	else
		CharacterStatsPane:Show();
	end
	--]]
	
end

--[[
function CharacterFrameExpandButton_OnClick()
	AllStatsShowFrame = not AllStatsShowFrame;
	if AllStatsShowFrame then
		AllStatsFrame:Show();
	else
		AllStatsFrame:Hide();
	end
end
--]]
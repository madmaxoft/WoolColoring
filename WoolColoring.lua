-- WoolColoring.lua

--[[
This simple plugin implements a small change in the gameplay - right-clicking on wool blocks or carpets
while holding a dye in hand re-colors the block to the corresponding color.
It's just like re-coloring sheep in vanilla.
--]]





local function onPlayerRightClick(aPlayer, aBlockX, aBlockY, aBlockZ, aBlockFace, aCursorX, aCursorY, aCursorZ)
	local inHand = aPlayer:GetEquippedItem()
	if (inHand.m_ItemType ~= E_ITEM_DYE) then
		return false
	end
	local world = aPlayer:GetWorld()
	local pos = Vector3i(aBlockX, aBlockY, aBlockZ)
	local clickedBlockType = world:GetBlock(pos)
	if (
		(clickedBlockType == E_BLOCK_WOOL) or
		(clickedBlockType == E_BLOCK_CARPET)
	) then
		-- The player clicked a wool block with a dye, re-color the wool block:
		world:SetBlock(pos, clickedBlockType, 15 - inHand.m_ItemDamage)
		-- world:SendBlockTo(aBlockX, aBlockY, aBlockZ, aPlayer)
		return true
	end
	return false
end




function Initialize(aPlugin)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_RIGHT_CLICK, onPlayerRightClick)

	return true
end

local MAX_DASH_DIST = 6
local DASH_DELAY_MS = 50

function calculate_pos_offset(direction, pos, offset)
    if direction == 0 then
         return Position(pos.x, pos.y - offset, pos.z)

    elseif direction == 1 then
         return Position(pos.x + offset, pos.y, pos.z)

    elseif direction == 2 then
         return Position(pos.x, pos.y + offset, pos.z)

    elseif direction == 3 then
         return Position(pos.x - offset, pos.y, pos.z)

    elseif direction == 4 then
         return Position(pos.x - offset, pos.y + offset, pos.z)

    elseif direction == 5 then
            return Position(pos.x + offset, pos.y + offset, pos.z)

    elseif direction == 6 then
            return Position(pos.x - offset, pos.y - offset, pos.z)

    elseif direction == 7 then
            return Position(pos.x + offset, pos.y - offset, pos.z)
    end
end

-- returns MAX_DASH_DIST if the path is clear
-- otherwise, returns the number of clear spaces up to the first obstacle
function compute_dash_length(direction, pos)
    local valid_spaces = 0
    for i = 1, MAX_DASH_DIST do
        -- check tile; if it's unoccupied, we can move up to i spaces
        local tile = Tile(calculate_pos_offset(direction, pos, i))
        if tile and tile:getCreatureCount() == 0 and not tile:hasProperty(CONST_PROP_IMMOVABLEBLOCKSOLID) then
            valid_spaces = i
        else
            break
        end
    end
    return valid_spaces
end

function onSay(player, words, param)
    local position = player:getPosition()
    local direction = player:getDirection()
    local dash_length = compute_dash_length(direction, position)
    
    function step(offset)
        player:teleportTo(calculate_pos_offset(direction, position, offset))
    end
    
    for i = 1, dash_length do
        addEvent(step, DASH_DELAY_MS * i, i)
    end
	return false
end
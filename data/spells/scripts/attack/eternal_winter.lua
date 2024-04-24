local combats = {}

for i = 1, #AREA_GROUPS do
	combats[i] = Combat()
	combats[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
	combats[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
	combats[i]:setArea(createCombatArea(AREA_GROUPS[i]))
end

function castGroup(creature, variant, groupIndex)
	combats[groupIndex]:execute(creature, variant)
end

function onCastSpell(creature, variant)
	for i = 1, #AREA_GROUPS do 
		addEvent(castGroup, 300 * i, creature, variant, i)
	end
end

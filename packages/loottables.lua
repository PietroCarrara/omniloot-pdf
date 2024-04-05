local base = require"packages.base"
local package = pl.class(base)
package._name = "loottables"

function package:registerCommands()
	local itemNumber = 0
	self:registerCommand("itemtable", function(options, content)
		itemNumber = 0

		SILE.typesetter:leaveHmode()
		SILE.call("font", { filename = "./fonts/Newcomen Black.otf", size = 24 }, function()
			SILE.call("strong", {}, function()
				SILE.typesetter:typeset(options["title"])
			end)
		end)
		SILE.typesetter:leaveHmode()
		SILE.process(content)
	end)

	self:registerCommand("item", function(options, content)
		itemNumber = itemNumber + 1

		SILE.call("font", {filename = "./fonts/Minion Pro Bold Display.otf", size = 14 }, function()
			SILE.typesetter:typeset(tostring(itemNumber) .. ". ")
		end)
		SILE.call("font", { filename = "./fonts/Minion Pro Display.otf", size = 12 }, function()
			SILE.process(content)
		end)
		SILE.typesetter:leaveHmode()
	end)
end

return package
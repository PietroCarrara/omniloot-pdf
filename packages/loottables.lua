local base = require("packages.base")
local package = pl.class(base)
package._name = "loottables"

function package:registerCommands()
	self:registerCommand("cover", function (options, _)

		SILE.call("center", {}, function ()
			SILE.call("skip", { height = "5cm" })

			SILE.call("font", { filename = "./fonts/Newcomen Black.otf", size = 36 }, function()
				SILE.typesetter:typeset(options["title"])
			end)

			SILE.call("skip", { height = "3cm" })

			SILE.call("font", { filename = "./fonts/Minion Pro Display.otf", size = 28 }, function()
				SILE.typesetter:typeset("This volume contains the following tables:")
			end)

			SILE.call("skip", { height = "1cm" })

			SILE.call("font", { filename = "./fonts/Newcomen Black.otf", size = 16 }, function()
				for _, i in ipairs(split(options["tables"], "|")) do
					SILE.call("par")
					SILE.typesetter:typeset(i)
				end
			end)
		end)

		SILE.call("pagebreak")
	end)

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
	end)
end

function split(inputstr, sep)
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

return package
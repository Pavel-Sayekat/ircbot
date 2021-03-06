------------------------------------------------------------------------
-- To create a new bot, copy this file along with "config.lua"
-- and the "plugins" directory to a new directory.
-- Edit the config file to suit your needs.
-- Execute main.lua to start the bot.
------------------------------------------------------------------------
require "irc.set"
local ircbot = require "ircbot"

-- Create a new bot.
local bot, config = ircbot.new("config.lua")

-- Load default bot plugins (found in ircbot/plugins).
assert(bot:loadDefaultPlugins())

-- Load bot plugins.
local plugins, err = bot:loadPluginsFolder(config.plugin_dir)
if not plugins then
	bot:log(err)
end

local set = irc.set.new{timeout = config.maxThinkInterval}

-- Add all bots to the set.
set:add(bot)

while true do
	local ready = set:poll()
	
	for k, bot in ipairs(ready) do
		bot:think()
	end
end

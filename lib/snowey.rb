
# Snowey
require "snowey/version"
require "snowey/constants"
require "snowey/logger"
require "snowey/parser"
require "snowey/service"

# Rubygems - Required
require "trollop"
require "eventmachine"

# Rubygems - Optional
begin; require "rainbow"; rescue LoadError => e; end

# Setup the available commands
Snowey::Parser::CommandManager.add_command "STATUS"
Snowey::Parser::CommandManager.add_command "ID", [:tag]
Snowey::Parser::CommandManager.add_command "INFO", [:tag]

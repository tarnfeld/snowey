
# Snowey
require "snowey/version"
require "snowey/constants"
require "snowey/logger"
require "snowey/parser"
require "snowey/commands"
require "snowey/allocator"
require "snowey/rangestore"
require "snowey/service"

# Rubygems - Required
require "trollop"
require "eventmachine"
require "redis"
require "aws"

# Rubygems - Optional
begin; require "rainbow"; rescue LoadError => e; end

# Setup the available commands
Snowey::Parser::CommandManager.add_command "STATUS"
Snowey::Parser::CommandManager.add_command "ID", [:tag]
Snowey::Parser::CommandManager.add_command "INFO", [:tag]

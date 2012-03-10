
# Snowey
require "snowey/version"
require "snowey/constants"
require "snowey/logger"
require "snowey/handler"
require "snowey/parser"
require "snowey/service"

# 3rd Party Rubygems
require "trollop"
require "eventmachine"

# Setup the available commands
Snowey::Parser::add_command "STATUS"
Snowey::Parser::add_command "ID", [:tag]
Snowey::Parser::add_command "INFO", [:tag]

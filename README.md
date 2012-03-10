# Snowey

Snowey is a ruby based service for generating uinque, incremental IDs in a distribtued environment (say, load balanced application servers). It's based around a similar idea to [Twitter Snowflake](http://github.com/twitter/snowflake) or [Flake](http://github.com/boundary/flake) except it works on a range basis, each instance of Snowey will alloate itself a range of IDs to use, and re-allocate itself more when it runs out.

Currently the only atomic range store is based on DynamoDB. Support for something like Redis or MySQL might be worked in.

**THIS IS A WIP**

## Installation

Ensure you have rubygems installed, and ruby 1.9.3 or newer. To install the gem via rubygems

    gem install snowey

You can compile and install them gem yourself with the following commands (rake required)

    git clone git://github.com/tarnfeld/snowey.git
    cd snowey && rake install

## Usage

To start up snowey, execute the following command. This will start a snowey server listening on all network interfaces on port 2478

    snowey

To see available options, execute the following comand

    snowey --help

## Contributing

1. Fork Snowey
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request in Github

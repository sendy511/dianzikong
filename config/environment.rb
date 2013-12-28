# Load the rails application
require File.expand_path('../application', __FILE__)

# Fix: Incompatible character encodings: ASCII-8BIT and UTF-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# Initialize the rails application
DianziKong::Application.initialize!

package = "kong-plugin-jwt-wego"
version = "1.0-3"
source = {
   url = "https://geeks.wego.com"
}
description = {
   summary = "JWT token validation by Wego.com",
   detailed = [[
      JWT token validation by Wego.com
   ]],
   homepage = "https://geeks.wego.com",
   license = "MIT"
}
dependencies = {
   "kong >= 0.10"
}
build = {
   type = "builtin",
   modules = {
    ["kong.plugins.jwt-wego.migrations.cassandra"] = "kong/plugins/jwt-wego/migrations/cassandra.lua",
    ["kong.plugins.jwt-wego.migrations.postgres"] = "kong/plugins/jwt-wego/migrations/postgres.lua",
    ["kong.plugins.jwt-wego.handler"] = "kong/plugins/jwt-wego/handler.lua",
    ["kong.plugins.jwt-wego.schema"] = "kong/plugins/jwt-wego/schema.lua",
    ["kong.plugins.jwt-wego.hooks"] = "kong/plugins/jwt-wego/hooks.lua",
    ["kong.plugins.jwt-wego.api"] = "kong/plugins/jwt-wego/api.lua",
    ["kong.plugins.jwt-wego.constants"] = "kong/plugins/jwt-wego/constants.lua",
    ["kong.plugins.jwt-wego.daos"] = "kong/plugins/jwt-wego/daos.lua",
    ["kong.plugins.jwt-wego.jwt_parser"] = "kong/plugins/jwt-wego/jwt_parser.lua",
    ["kong.plugins.jwt-wego.asn_sequence"] = "kong/plugins/jwt-wego/asn_sequence.lua",
   }
}

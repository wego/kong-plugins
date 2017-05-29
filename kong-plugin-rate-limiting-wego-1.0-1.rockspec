package = "kong-plugin-rate-limiting-wego"
version = "1.0-1"
source = {
   url = "https://geeks.wego.com"
}
description = {
   summary = "Rate limiting by Wego.com",
   detailed = [[
      Rate limiting by Wego.com
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
    ["kong.plugins.rate-limiting-wego.migrations.cassandra"] = "kong/plugins/rate-limiting-wego/migrations/cassandra.lua",
    ["kong.plugins.rate-limiting-wego.migrations.postgres"] = "kong/plugins/rate-limiting-wego/migrations/postgres.lua",
    ["kong.plugins.rate-limiting-wego.handler"] = "kong/plugins/rate-limiting-wego/handler.lua",
    ["kong.plugins.rate-limiting-wego.schema"] = "kong/plugins/rate-limiting-wego/schema.lua",
    ["kong.plugins.rate-limiting-wego.daos"] = "kong/plugins/rate-limiting-wego/daos.lua",
    ["kong.plugins.rate-limiting-wego.policies"] = "kong/plugins/rate-limiting-wego/policies/init.lua",
    ["kong.plugins.rate-limiting-wego.policies.cluster"] = "kong/plugins/rate-limiting-wego/policies/cluster.lua"
   }
}

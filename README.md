## Wego custom [Kong](https://www.getkong.org) plugins

Contents:

#### Wego JWT plugin

#### Wego Rate-limiting plugin

These two plugins are forked from the standard Kong plugins, and have some Wego-specific changes applied.

The only difference in `JWT` plugins is that we set some additional headers that are read from the JWT token:

```
  ngx_set_header(local_constants.HEADERS.TOKEN_USER_ID, claims['uid'])
  ngx_set_header(local_constants.HEADERS.TOKEN_USER_EMAIL, claims['sub'])
  ngx_set_header(local_constants.HEADERS.TOKEN_SCOPES, claims['aud'])

  ngx.ctx.authenticated_user_id = claims['uid']

```

and we have defined the required variables:

```
return {
  HEADERS = {
    TOKEN_USER_ID = "X-Consumer-Token-User-Id",
    TOKEN_USER_EMAIL = "X-Consumer-Token-User-Email",
    TOKEN_SCOPES = "X-Consumer-Token-Scopes"
	}
}
```

We then use the value for `ngx.ctx.authenticated_user_id = claims['uid']` in the Wego Rate Limiter plugin.

The change here is that we add a new `limit_by` constant - user.
Then we set the identifier for rate limit to:

```
  elseif conf.limit_by == "user" then
    identifier = ngx.ctx.authenticated_user_id
```

This way the rate limit is counted against the user_id from the JWT token, and not against the Consumer ID or against IP.

## Development

To use the plugin in you local kong, you need to compile and install the plugin as a rock.

```
$ luarocks make <rockspec>
```

## Release

### Create the rock

```
$ luarocks pack <plugin name>
```

example

```
$ luarocks pack kong-plugin-jwt-wego
  adding: doc/ (stored 0%)
  adding: doc/README.md (deflated 54%)
  adding: kong-plugin-jwt-wego-1.0-3.rockspec (deflated 70%)
  adding: lua/ (stored 0%)
  adding: lua/kong/ (stored 0%)
  adding: lua/kong/plugins/ (stored 0%)
  adding: lua/kong/plugins/jwt-wego/ (stored 0%)
  adding: lua/kong/plugins/jwt-wego/api.lua (deflated 73%)
  adding: lua/kong/plugins/jwt-wego/asn_sequence.lua (deflated 71%)
  adding: lua/kong/plugins/jwt-wego/constants.lua (deflated 45%)
  adding: lua/kong/plugins/jwt-wego/daos.lua (deflated 60%)
  adding: lua/kong/plugins/jwt-wego/handler.lua (deflated 71%)
  adding: lua/kong/plugins/jwt-wego/hooks.lua (deflated 51%)
  adding: lua/kong/plugins/jwt-wego/jwt_parser.lua (deflated 69%)
  adding: lua/kong/plugins/jwt-wego/migrations/ (stored 0%)
  adding: lua/kong/plugins/jwt-wego/migrations/cassandra.lua (deflated 62%)
  adding: lua/kong/plugins/jwt-wego/migrations/postgres.lua (deflated 64%)
  adding: lua/kong/plugins/jwt-wego/schema.lua (deflated 49%)
  adding: rock_manifest (deflated 53%)
Packed: kong-plugins/kong-plugin-jwt-wego-1.0-3.all.rock
```

Release a new version in gihut with the new `.all.rock`

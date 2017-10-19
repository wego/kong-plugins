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
Packed: kong-plugins/kong-plugin-jwt-wego-1.0-3.all.rock
```

Release a new version in github with the new `.all.rock`

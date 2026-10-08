# Activating & defining static scopes

1. Enable this submodule.
2. Set the scope provider to static: on `/admin/config/people/simple_oauth`, or
   `drush config:set simple_oauth.settings scope_provider static -y`.
3. Declare scopes in a `MODULE.oauth2_scopes.yml` at the root of any enabled module.

## YAML structure
```yaml
"content:read":
  description: 'Read published content.'   # required
  umbrella: false                          # required; true = parent-only, aggregates children
  grant_types:                             # required
    client_credentials:
      status: true                         # required
      description: 'Read content via client credentials.'
    authorization_code:
      status: true
  parent: "content"                        # optional: parent scope id
  granularity: permission                  # required if umbrella=false: permission | role
  permission: 'access content'             # required if granularity=permission
  # role: 'authenticated'                  # required if granularity=role
```

Known grant type ids: `authorization_code`, `client_credentials`, `refresh_token` (must match
enabled `Oauth2Grant` plugins). Umbrella scopes omit `granularity`/`permission`/`role` and
just group children via each child's `parent`.

View all discovered static scopes read-only at
`/admin/config/people/simple_oauth/oauth2_scope/static` (routes
`plugin.oauth2_scope.collection` / `plugin.oauth2_scope.view`, permission `view oauth2 scopes`).
Clearing caches re-reads the YAML.

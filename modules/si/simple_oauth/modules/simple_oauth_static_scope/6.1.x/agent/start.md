# simple_oauth_static_scope — agent start

Submodule of `simple_oauth`. Adds a **static** scope provider: OAuth2 scopes declared as YAML
plugins in code instead of config entities. Enable it, then set
`simple_oauth.settings.scope_provider: static`. Read-only listing:
`/admin/config/people/simple_oauth/oauth2_scope/static`.

- Activate static scopes + define them in YAML → [configure/static-scopes.md](configure/static-scopes.md)
- The `Oauth2Scope` plugin type it defines → [plugins/oauth2-scope.md](plugins/oauth2-scope.md)

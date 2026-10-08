# Oauth2Scope plugin type

This submodule defines the **Oauth2Scope** plugin type, discovered from YAML rather than PHP
classes.

- Manager: `plugin.manager.oauth2_scope`
  (`Drupal\simple_oauth_static_scope\Plugin\Oauth2ScopeManager`, a YAML discovery manager).
- Discovery file: `MODULE.oauth2_scopes.yml` at any enabled module's root.
- It plugs into Simple OAuth as the `static` scope provider (a `ScopeProvider` plugin), so it
  only takes effect when `simple_oauth.settings.scope_provider` is `static`.

You normally never write PHP for this — you author scope definitions in YAML (see
[../configure/static-scopes.md](../configure/static-scopes.md)). The manager validates each
definition against the known grant-type plugins and the chosen granularity
(`permission`/`role`) from the parent Simple OAuth module, then exposes them as scope objects
the OAuth2 server uses to authorize tokens.

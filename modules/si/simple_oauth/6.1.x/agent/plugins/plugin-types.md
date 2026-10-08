# Plugin types defined

Simple OAuth defines three plugin types. Each has a manager (`parent: default_plugin_manager`)
and both `@Annotation` and PHP `#[Attribute]` discovery.

## Oauth2Grant — `Plugin/Oauth2Grant/`
Manager `plugin.manager.oauth2_grant.processor`, interface `Oauth2GrantInterface`
(extend `Oauth2GrantBase`), annotation `@Oauth2Grant`. Wraps a league/oauth2-server grant and
returns it configured for the authorization server. Core plugins: `AuthorizationCode`,
`ClientCredentials`, `RefreshToken`. Alter hook: `hook_simple_oauth_oauth2_grant_info_alter`.

```php
#[Oauth2Grant(id: 'my_grant', label: new TranslatableMarkup('My grant'))]
class MyGrant extends Oauth2GrantBase {
  public function getGrantType(ConsumerInterface $client): GrantTypeInterface { /* ... */ }
}
```

## ScopeProvider — `Plugin/ScopeProvider/`
Manager `plugin.manager.scope_provider`, interface `ScopeProviderInterface`
(extend `ScopeProviderBase`), annotation `@ScopeProvider`. Supplies the set of available
scopes; the active one is selected by `simple_oauth.settings.scope_provider`. Core plugin:
`DynamicScopeProvider` (config entities). The static-scope submodule adds a `static` provider.

## ScopeGranularity — `Plugin/ScopeGranularity/`
Manager `plugin.manager.scope_granularity`, interface `ScopeGranularityInterface`
(extend `ScopeGranularityBase`). Maps a scope to concrete Drupal access. Core plugins:
`Permission` (scope → permission) and `Role` (scope → role). Its config schema key is
`simple_oauth_scope_granularity.<plugin_id>`.

Register plugins from your module's `src/Plugin/<Type>/` namespace — the managers autodiscover
them.

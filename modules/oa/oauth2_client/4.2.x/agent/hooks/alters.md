# Hooks — altering plugin definitions

Declared in `oauth2_client.api.php`. Both are standard plugin-definition alters
(`DefaultPluginManager::alterDefinitions`).

## `hook_oauth2_client_info_alter(array &$definitions)`

Alter discovered **`oauth2_client`** plugin definitions (keyed by plugin id). Use it to tweak a
client's endpoints, scopes, request options, etc. without editing the plugin class.

```php
function mymodule_oauth2_client_info_alter(array &$definitions) {
  $definitions['my_provider']['scopes'] = ['read', 'write'];
}
```

## `hook_oauth2_grant_type_info_alter(array &$definitions)`

Alter **`oauth2_grant_type`** plugin definitions. Notably you can swap the `class` of an existing
grant id to replace its implementation site-wide **without** introducing a new plugin id — e.g.
customize how `authorization_code` obtains a token:

```php
function mymodule_oauth2_grant_type_info_alter(array &$definitions) {
  $definitions['authorization_code']['class'] = '\Drupal\mymodule\Plugin\Oauth2GrantType\MyAuthorizationCode';
}
```

The API doc warns to be cautious overriding an existing plugin's `class`: the replacement must
fully honor the original behavior contract (`Oauth2GrantTypeInterface`).

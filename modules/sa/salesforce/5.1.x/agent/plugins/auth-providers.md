# Auth-provider plugins & `salesforce_auth`

## Plugin type

- Manager: `plugin.manager.salesforce.auth_providers`
  (`SalesforceAuthProviderPluginManager`), annotation `@SalesforceAuthProvider`.
- Discovery: `src/Plugin/SalesforceAuthProvider/` in each module.
- Base: `SalesforceAuthProviderPluginBase`; interface `SalesforceAuthProviderInterface`.
- Shipped providers:
  - `oauth` (salesforce_oauth) — OAuth user-agent flow.
  - `jwt` and `jwt_govcloud` (salesforce_jwt) — key-based JWT auth (needs a Key entity).

## The `salesforce_auth` config entity

Each authorization is a `salesforce_auth` config entity (`SalesforceAuthConfig`) that stores:
- `id`, `label`
- `provider` — the auth-provider plugin id (`oauth` / `jwt` / `jwt_govcloud`)
- `provider_settings` — plugin-specific settings (consumer key, login URL, key id, …)

The default authorization used by the client is the id in
`salesforce.settings.salesforce_auth_provider`.

```bash
drush salesforce:list-providers           # list configured authorizations
drush cget salesforce.settings salesforce_auth_provider
drush cset salesforce.settings salesforce_auth_provider my_auth -y
```

> Creating/authorizing a `salesforce_auth` normally happens through the auth submodule's UI
> (`salesforce.auth_config` route), because completing OAuth/JWT requires talking to
> Salesforce. The config entity itself is local, but a usable connection needs the external
> org.

## Implement a custom auth provider

```php
namespace Drupal\my_module\Plugin\SalesforceAuthProvider;

use Drupal\salesforce\SalesforceAuthProviderPluginBase;

/**
 * @SalesforceAuthProvider(
 *   id = "my_auth",
 *   label = @Translation("My auth"),
 *   credentials_class = "\\Drupal\\my_module\\Consumer\\MyCredentials"
 * )
 */
class MyAuthProvider extends SalesforceAuthProviderPluginBase { /* ... */ }
```

Token storage is handled by `salesforce.auth_token_storage`
(`SalesforceAuthTokenStorage`, backed by State).

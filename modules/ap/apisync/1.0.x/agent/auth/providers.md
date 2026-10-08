<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Authentication — auth provider plugin type & apisync_auth config entity

## Plugin type `apisync_auth_provider`
- Manager: `Drupal\apisync\ApiSyncAuthProviderPluginManager` (service `plugin.manager.apisync.auth_providers`, interface `…PluginManagerInterface`). Discovery dir `Plugin/ApiSyncAuthProvider`, cache `apisync_auth_provider`, alter hook `apisync_auth_provider_info`, fallback plugin id `broken` (`src/Plugin/ApiSyncAuthProvider/Broken.php`).
- Annotation: `Drupal\apisync\Annotation\ApiSyncAuthProvider` (`id`, `label`, `credentials_class`).
- Interface: `ApiSyncAuthProviderInterface` — `id()`, `label()`, `isTokenBasedProvider()`, `getAccessToken()`, `hasAccessToken()`, `refreshAccessToken()`, `clearAccessToken()`, `appendAuthHeaders(array $headers)`, plus `PluginFormInterface` (build/validate/submit config form).
- Base: `ApiSyncAuthProviderPluginBase` — holds `$configuration`, `getConfiguration($key)`, `setConfiguration()`, default `submitConfigurationForm()` writes `provider_settings`.
- Shipped providers: `basic_auth` (submodule `apisync_basicauth`), `apisync_oauth` (submodule `apisync_oauth`). Add your own by placing a plugin in a module's `Plugin/ApiSyncAuthProvider/`.

The manager is what `ODataClient` calls: `appendAuthHeaders()`, `isTokenBasedProvider()`, `clearAccessToken()` all delegate to the active provider resolved from config.

## Config entity `apisync_auth`
`Drupal\apisync\Entity\ApiSyncAuthConfig` — `@ConfigEntityType(id="apisync_auth")`, `admin_permission = authorize apisync`. `config_export`: `id`, `label`, `provider`, `provider_settings`. Default `provider = 'basic_auth'`. `getPlugin()` instantiates the provider with `getProviderSettings()` (= `provider_settings + ['id' => id]`) via a `DefaultSingleLazyPluginCollection`.

The manager (`getProvider()`/`getConfig()`) loads the entity named by `apisync.settings:apisync_auth_provider` and returns its plugin. That one active provider authenticates every OData request.

## UI & routes (base module)
`apisync.routing.yml`: `apisync.auth_config` (form `ApiSyncAuthSettings`), `entity.apisync_auth.collection` (list, `ApiSyncAuthListBuilder`), `add_form`/`edit_form` (`ApiSyncAuthForm`), `revoke` (`ApiSyncAuthRevokeForm`), `delete_form` (`ApiSyncAuthDeleteForm`) — all under `/admin/config/apisync/authorize`, gated by `authorize apisync` or entity access. `ApiSyncAuthForm` renders the chosen provider's plugin form via AJAX and can set the saved config as the default provider.

## Operating
1. Enable an auth submodule (`apisync_basicauth` or `apisync_oauth`).
2. Set `instance_url` (HTTPS) in global settings.
3. Add an `apisync_auth` config, pick the provider, enter its settings, save as default.
4. Provider credentials are secrets — keep the `authorize apisync` permission restricted (it is `restrict access: TRUE`) and prefer OAuth (which stores its client secret through the Key-backed `oauth2_client` module).

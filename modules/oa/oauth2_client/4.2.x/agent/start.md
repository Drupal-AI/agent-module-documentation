# OAuth2 Client — agent index

Makes Drupal an OAuth2 **client**. You (a) write an `Oauth2Client` **plugin** describing a
provider's endpoints + grant type, (b) create an `oauth2_client` **config entity** that binds
that plugin to stored credentials, then (c) call the `oauth2_client.service` to get/refresh/clear
access tokens. Built on `league/oauth2-client`. Requires PHP 8.3+, core ^11.4. Optional Key module
for credential storage. Submodule `oauth2_client_example_plugins` provides working examples.

- **Define a client plugin + define/override a grant type plugin (the two plugin types)** →
  [plugins/client-and-grant.md](plugins/client-and-grant.md)
- **Get/refresh/clear tokens at runtime; the service, redirect route, storage traits** →
  [api/service.md](api/service.md)
- **Create/manage the `oauth2_client` config entity (credentials, providers, admin UI, drush)** →
  [configure/client-entity.md](configure/client-entity.md)
- **Alter plugin definitions (`hook_oauth2_client_info_alter`, `hook_oauth2_grant_type_info_alter`)** →
  [hooks/alters.md](hooks/alters.md)

Key facts:
- Plugin types (services): `oauth2_client.plugin_manager` (id `oauth2_client`) and
  `plugin.manager.oauth2_grant_type` (id `oauth2_grant_type`).
- Grant type plugin ids: `authorization_code`, `client_credentials`, `resource_owner`, `refresh_token`.
- Config entity type `oauth2_client` (config prefix `oauth2_client.oauth2_client.*`); exported keys:
  `id, label, description, oauth2_client_plugin_id, credential_provider, credential_storage_key`
  (+ `status`, defaults FALSE). `credential_provider` = `oauth2_client` (Drupal State) or `key`.
- Admin: `/admin/config/system/oauth2-client` (route `entity.oauth2_client.collection`),
  permission `administer oauth2 clients`. Code-capture route: `oauth2_client.code`
  (`/oauth2-client/{plugin}/code`).
- Runtime service: `oauth2_client.service` → `getClient()`, `getAccessToken()`,
  `retrieveAccessToken()`, `clearAccessToken()`.

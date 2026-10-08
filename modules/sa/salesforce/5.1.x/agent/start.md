# Salesforce Integration — agent index

Base module of the Salesforce suite: the authenticated **REST client**, SOQL helpers, an
**auth-provider plugin system**, Drush commands, value objects and events. Real sync comes
from submodules. Configure route: `salesforce.admin_config_salesforce` (`/admin/config/salesforce`).
Requires external libs + Drupal `key`, `address`, `dynamic_entity_reference`, `typed_data`.

- **Suite-wide settings (`salesforce.settings`): push/pull limits, standalone, use_latest, default auth provider** →
  [configure/settings.md](configure/settings.md)
- **The REST client, SOQL `SelectQuery`, value objects (`SObject`, `SFID`)** →
  [api/client.md](api/client.md)
- **Auth-provider plugin type + the `salesforce_auth` config entity** →
  [plugins/auth-providers.md](plugins/auth-providers.md)
- **The 15 `salesforce:*` Drush commands** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Service `salesforce.client` → `Drupal\salesforce\Rest\RestClient`.
- Plugin type: `plugin.manager.salesforce.auth_providers`, annotation
  `@SalesforceAuthProvider`; each authorization is a `salesforce_auth` config entity.
  Providers: `oauth` (salesforce_oauth), `jwt` / `jwt_govcloud` (salesforce_jwt).
- Config `salesforce.settings`: `global_push_limit`, `pull_max_queue_size`, `standalone`
  (bool), `show_all_objects` (bool), `use_latest` (bool), `limit_mapped_object_revisions`,
  `salesforce_auth_provider` (default auth id), `short_term_cache_lifetime`,
  `long_term_cache_lifetime`, `rest_api_version`.
- Permissions: `administer salesforce`, `authorize salesforce` (both restricted).
- Submodules: mapping, mapping_ui, push, pull, jwt, oauth, logger, soap, address, webform,
  example (each documented under `modules/`).

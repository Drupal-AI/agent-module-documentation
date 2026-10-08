# Entity types and their settings forms

apigee_edge registers three Apigee-backed entity types (all defined with the module's own
`@\Drupal\apigee_edge\Annotation\EdgeEntityType`, none stored in SQL — they proxy the Apigee SDK):

| Entity type id | What it is | Access / permission provider |
|---|---|---|
| `developer` | An Apigee developer, 1:1 with a Drupal user (email = developer id). | `EdgeEntityAccessControlHandler`; no dedicated permissions (managed with users). |
| `developer_app` | A developer's app (holds credentials / API keys, associated API products). | `EdgeEntityAccessControlHandler` + `DeveloperAppPermissionProvider`. |
| `api_product` | An Apigee API product (bundle of API proxies + quota). | core `EntityAccessControlHandler`; visibility gated by `hook_api_product_access` (see hooks). |

Developer ↔ user mapping is done by `UserDeveloperConverter` on user presave/register/cancel
(`apigee_edge_user_presave`, `_user_cancel`, `_user_delete`), and by developer synchronization
(see [../drush/commands.md](../drush/commands.md)).

## Settings forms (all under `/admin/config/apigee-edge`, permission `administer apigee edge`)

All live under menu **Configuration → Apigee** (`apigee_edge.admin_config_edge`).

### General / connection
- `apigee_edge.settings` — Credentials (`AuthenticationForm`) — see [connection.md](connection.md).
- `apigee_edge.settings.connection_config` — timeouts/proxy (`ConnectionConfigForm`).
- `apigee_edge.settings.error_page` — `ErrorPageSettingsForm`.

### Developers (`apigee_edge.settings.developer*`)
- `DeveloperSettingsForm` — registration/verification behavior. Config `apigee_edge.developer_settings`
  (`verification_action`, verification/error messages, `verification_email`, cache).
- `DeveloperAttributesSettingsForm` — which user fields sync as developer attributes.
- `DeveloperSyncForm` — run/schedule developer sync (also routes
  `apigee_edge.developer_sync.schedule|run`, CSRF-protected, `DeveloperSyncController`).
- `DeveloperCachingForm` — cache expiration.
- `ApiProductAccessControlForm` (`/developer-settings/access-control`) — maps API-product
  visibility (`public`/`private`/`internal`) to Drupal roles. Config `apigee_edge.api_product_settings:access`.
  (The RBAC submodule replaces this form's visibility model — see that submodule.)

### API products (`apigee_edge.settings.product.*`)
- `ApiProductAliasForm` — relabel the entity ("API"/"APIs") + required/locked base fields. Config
  `apigee_edge.api_product_settings` (`entity_label_singular/plural`, cache).
- `ApiProductCachingForm` — cache expiration.

### Apps (`apigee_edge.settings.*app*`)
- `AppSettingsForm` (general) — config `apigee_edge.common_app_settings`: `display_as_select`,
  `user_select`, `multiple_products`, `default_products`, analytics environments, callback-url pattern.
- `AppCallbackUrlSettingsForm`, `AppAnalyticsSettingsForm`.
- `DeveloperAppAliasForm` — relabel developer_app + required/locked base fields; config
  `apigee_edge.developer_app_settings` (`entity_label_*`, `required_base_fields`, `locked_base_fields`,
  `credential_lifetime`, cache).
- `EdgeEntityDisplaySettingsForm` (display settings, `display_type`/`view_mode`) — reused per entity
  type via route default `entity_type_id`.
- `DeveloperAppCredentialsForm`, `DeveloperAppCachingForm`.

### Sync scope
Config `apigee_edge.sync`: `filter` (Apigee query filter) and `user_fields_to_sync`.

## Set values via PHP
```php
// Rename the API Product entity label and allow multiple products per app.
\Drupal::configFactory()->getEditable('apigee_edge.common_app_settings')
  ->set('multiple_products', TRUE)->save();
\Drupal::configFactory()->getEditable('apigee_edge.api_product_settings')
  ->set('entity_label_singular', 'API')->set('entity_label_plural', 'APIs')->save();
```

## Fields
Base fields for the Apigee entities are declared in `apigee_edge_entity_base_field_info()` /
`_alter()`; extra display in `apigee_edge_entity_extra_field_info()`. Custom **developer attributes**
become fields via `FieldAttributeConverter` / the `ApigeeFieldStorageFormat` plugins
(see [../plugins/plugins.md](../plugins/plugins.md)).

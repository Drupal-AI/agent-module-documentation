# Settings form

Route `ant_bulk.settings` → `/admin/config/regional/ant-bulk-settings`, form
`Drupal\ant_bulk\Form\SettingsForm` (id `ant_bulk_settings`, extends `ConfigFormBase`),
permission `administer site configuration`, `_admin_route: TRUE`. Linked as "Ant Bulk Settings"
under `system.admin_config_regional`.

## Config object

Editable config: `ant_bulk.settings` (`getEditableConfigNames()`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `status` | bool | unset (falsy) | "Only translate published content". When true, the UI bulk run and its on-form node counts only consider published nodes. |

No `config/schema/*.yml` and no `config/install/*.yml` ship with the module, so the config object is
created on first save and has no schema definition.

## Set it without the UI

Drush:

```bash
drush config:set ant_bulk.settings status 1 -y
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('ant_bulk.settings')
  ->set('status', TRUE)
  ->save();
```

## Scope

- Only the **UI** path (`TranslateForm` → `TranslationManager::getNodes()`) reads `status`.
- The Drush command `ant_bulk:translate` does **not** read this config: it always passes the default
  `status = FALSE`, so CLI runs include unpublished nodes regardless of this setting.

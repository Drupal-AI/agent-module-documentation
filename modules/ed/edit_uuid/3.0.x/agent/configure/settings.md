# Configure which entity types/bundles expose the UUID field

The module has no global settings object. Instead you create one or more
`edit_uuid_config` **config entities**, each of which turns on the UUID field
for one entity type and a chosen set of its bundles.

## UI

- Collection / list: `/admin/config/development/edit-uuid-config`
  (route `entity.edit_uuid_config.collection`, also the module's `configure` link,
  linked under *Configuration → Development*).
- Add: `/admin/config/development/edit-uuid-config/add` (route `edit_uuid_config.add`,
  "Create UUID configuration" local action).
- Edit: `/admin/config/development/edit-uuid-config/manage/{edit_uuid_config}`.
- Delete: `.../manage/{edit_uuid_config}/delete`.

All four routes require the `administer edit_uuid_config configuration` permission
(the edit route via `_entity_access: edit_uuid_config.update`, whose access handler
checks the same permission).

## Add/edit form fields

Form class `Drupal\edit_uuid\EditUuidConfigForm` (extends `BundleEntityFormBase`).

| Field (form key) | Stored key | Type | Notes |
|---|---|---|---|
| Settings Name | `label` | textfield, required | Free-text name for the config. |
| Machine id | `id` | machine_name, `#maxlength: 23` | Uniqueness via `EditUuidConfig::load`. |
| Entity Type | `config_key` | select, required | Options = every `ContentEntityType` definition on the site. |
| Bundle | `config_value` | multi-select | AJAX-populated from `config_key` (callback `getBundles`, wrapper `#bundle-to-update`). Stores an array of bundle ids. |
| Just show UUID & disable editing | `config_type` | checkbox | TRUE → the UUID field is rendered disabled (view-only) for this config's bundles. FALSE → editable mode. |

Notes (from README): create a **separate** config for each distinct
entity-type/bundle combination — saving an existing config overwrites it. There
is no de-duplication across configs; the form_alter iterates all configs and the
last matching one wins per form.

## Config object shape

Config entity id `edit_uuid_config`, `config_prefix: form`, so each saved config
is `edit_uuid_config.form.<id>`. Exported keys: `id`, `label`, `config_key`,
`config_value`, `config_type`. Example YAML:

```yaml
# config/…/edit_uuid_config.form.article_uuid.yml
id: article_uuid
label: 'Article UUID'
config_key: node
config_value:
  article: article
config_type: false
```

## Create via PHP / drush

```php
\Drupal::entityTypeManager()->getStorage('edit_uuid_config')->create([
  'id' => 'article_uuid',
  'label' => 'Article UUID',
  'config_key' => 'node',
  'config_value' => ['article' => 'article'],
  'config_type' => FALSE,
])->save();
```

Run with `drush php:eval '...'` or import the YAML via `drush config:import`.

## Config schema caveat

`config/schema/edit_uuid_config.schema.yml` (type `edit_uuid_config.form.*`,
`config_entity`) only maps `id` and `label`. `config_key`, `config_value`, and
`config_type` are in `config_export` but are **not** described in the schema, so
they carry no typed-data definition (config validation/translation will not see
them). Behavior still works because storage reads them directly via the accessors.

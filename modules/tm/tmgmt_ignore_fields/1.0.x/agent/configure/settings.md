<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the ignored fields

All configuration is one settings form and one config key. There is no per-widget or per-bundle
setting — the ignore list is global.

## The settings form

- Route `tmgmt_ignore_fields_settings_form` → `/admin/config/content/tmgmt-ignore-fields`
  (admin menu: Configuration → Content authoring → "Ignore Fields Settings").
- Permission: core `administer site configuration`.
- Class `Drupal\tmgmt_ignore_fields\Form\IgnoreFieldsSettingsForm` (extends `ConfigFormBase`), form id
  `tmgmt_ignore_fields_settings`.

`buildForm()` (`IgnoreFieldsSettingsForm.php:104`) enumerates **every content entity type**
(`entityClassImplements(ContentEntityInterface::class)`) and builds a two-column checkbox table:

- **Base Fields** — from `entityFieldManager->getBaseFieldDefinitions($entity_type_id)`.
- **Custom Fields** — from `getFieldDefinitions($entity_type_id, $bundle)` for each bundle, minus any
  name already listed as a base field.

Each checkbox's label is `"<EntityType label>: <Field label> (<field_name>)"`; its stored value is the
bare `#field_name` (the field machine name). `submitForm()` (`:206`) collects the checked
`#field_name`s, `array_unique`/`array_filter`s them, and writes the flat list to config.

Important consequence: because the value saved is only the field machine name, the ignore decision is
**not scoped to an entity type or bundle**. The form may show the same machine name (e.g. `body`) once
per entity type, but checking any of them ignores that name for every content entity that has it. If a
name collides across entity types, they are indistinguishable in the saved list.

## The config

```yaml
# tmgmt_ignore_fields.settings
ignore_fields:        # sequence of field machine names, e.g.
  - body
  - field_internal_code
```

Schema `config/schema/tmgmt_ignore_fields.schema.yml`: `type: config_object`, `ignore_fields` is a
`sequence` of `string`. Install default is empty (`ignore_fields: { }`).

Set it from code instead of the form:

```php
\Drupal::configFactory()->getEditable('tmgmt_ignore_fields.settings')
  ->set('ignore_fields', ['body', 'field_internal_code'])
  ->save();
```

Read the current list:

```php
$ignored = \Drupal::config('tmgmt_ignore_fields.settings')->get('ignore_fields') ?? [];
```

## How the exclusion actually happens

1. `tmgmt_ignore_fields_tmgmt_source_plugin_info_alter()` (`tmgmt_ignore_fields.module:16`) runs when
   TMGMT builds its source-plugin registry. If the `content` source is still tmgmt_content's stock
   `ContentEntitySource`, it rewrites `$info['content']['class']` to
   `IgnoreFieldsContentEntitySource`. (If some other module already replaced that class, the swap is
   skipped — the `=== ContentEntitySource::class` guard means the two modules do not compose.)
2. When TMGMT extracts a job item, it calls the source's
   `extractTranslatableData()`. `IgnoreFieldsContentEntitySource::extractTranslatableData()`
   (`IgnoreFieldsContentEntitySource.php:63`) calls `parent::extractTranslatableData($entity)`, then
   loops the result and `unset()`s any **top-level key** that is in `ignore_fields`:

   ```php
   $ignore_fields = $this->configFactory->get('tmgmt_ignore_fields.settings')->get('ignore_fields') ?? [];
   $data = parent::extractTranslatableData($entity);
   foreach ($data as $key => $item) {
     if (in_array($key, $ignore_fields, TRUE)) {
       unset($data[$key]);
     }
   }
   ```

   The comparison is against the parent data's top-level keys, which are field machine names, so an
   ignored field's entire subtree is dropped from the job.

Notes for agents:
- Matching is only top-level (a field name), so you cannot ignore a single delta/column of a field —
  the whole field is excluded or none of it.
- Ignoring referenced entities (e.g. paragraphs) works because the referring field's key is dropped,
  so TMGMT never descends into it.
- Changes to the ignore list take effect for jobs created afterward; already-extracted job items are
  not rewritten.

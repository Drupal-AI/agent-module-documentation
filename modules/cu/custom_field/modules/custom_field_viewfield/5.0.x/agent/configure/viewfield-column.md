<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add & configure a viewfield column in a Custom Field

`custom_field_viewfield` adds one subfield type to Custom Field. Everything lives inside a normal
`custom` field — there is no separate field type, settings form or route.

## 1. Define the column (field storage)

A viewfield column goes in the `custom` field storage `columns` setting:

```php
$storage = \Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_sections', 'entity_type' => 'node', 'type' => 'custom',
  'settings' => ['columns' => [
    'listing' => ['name' => 'listing', 'type' => 'viewfield', 'target_type' => 'view'],
  ]],
]);
$storage->save();
```

The parent module normalises a `viewfield` column to `target_type: view` (see
`custom_field_update_10003`). Read it back with
`drush cget field.storage.node.field_sections` → `settings.columns.listing.type: viewfield`.

## 2. Choose the widget (entity form display)

Per-column widget selection is stored in the Custom Field widget component under
`settings.fields.<column>.type`:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_sections');           // custom_stacked | custom_flex
$c['settings']['fields']['listing']['type'] = 'viewfield_select';
$fd->setComponent('field_sections', $c)->save();
```

`viewfield_select` renders a select for the target view + display (and arguments) on the edit form.

## 3. Choose the formatter (entity view display)

Symmetrically, on the view display the Custom Field formatter's `settings.fields.<column>.type`
selects `viewfield_default`, which executes the referenced view and renders its output:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_sections');           // custom_formatter | custom_table | …
$c['settings']['fields']['listing']['format_type'] = 'viewfield_default';
$vd->setComponent('field_sections', $c)->save();
```

(Custom Field formatter components key subfield formatters under `settings.fields.<column>` — the
exact key is `format_type`; read an existing display back to confirm.)

## Feeds

The module also registers a `CustomFieldFeedsType` target `viewfield`, so a viewfield column can be
a mapping target on a Feeds importer (requires the `feeds` module + `custom_field`'s Feeds support).

## Config schema

There is no `config/schema` file; the plugin's settings schema is injected at runtime by
`hook_config_schema_info_alter()` in `src/Hook/ConfigSchemaHooks.php`.

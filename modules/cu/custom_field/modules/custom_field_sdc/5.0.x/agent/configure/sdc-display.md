<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bind a view mode to an SDC component

## Where it's stored

The binding is a **third-party setting on the `entity_view_display`** config entity:

```yaml
# core.entity_view_display.node.article.default
third_party_settings:
  custom_field_sdc:
    settings:
      enabled: true
      component: 'navigation:badge'   # a real SDC plugin id
      variant: ''                     # optional component variant
      props: { }                      # column -> prop value mappings (dynamic_property)
      slots: { }                      # slot name -> { source: field, field: <field_name> }
```

Config schema: `core.entity_view_display.*.*.*.third_party.custom_field_sdc` →
`custom_field_sdc.third_party_settings` (`settings.enabled` bool, `settings.component` string,
`settings.variant` string, `settings.props` sequence, `settings.slots` sequence).

## Via the UI

1. Go to the bundle's *Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. Open **"Custom Field - Single directory component options"**.
3. Tick **"Render using a component"**.
4. Choose a **Component** from the select (only valid, non-`noUi` components are listed).
5. Map any **Props** (from Custom Field columns) and **Slots** (from other fields).
6. Save. Unchecking "Render using a component" **removes** the third-party setting entirely.

## Scriptable (drush php:eval)

```php
$s = \Drupal::entityTypeManager()->getStorage('entity_view_display');
$vd = $s->load('node.article.default')
  ?: $s->create(['targetEntityType' => 'node', 'bundle' => 'article', 'mode' => 'default', 'status' => TRUE]);
$vd->setThirdPartySetting('custom_field_sdc', 'settings', [
  'enabled' => TRUE,
  'component' => 'navigation:badge',
  'props' => [], 'slots' => [],
])->save();
```

Read it back:
```bash
drush cget core.entity_view_display.node.article.default third_party_settings.custom_field_sdc
```
Or in PHP: `$vd->getThirdPartySetting('custom_field_sdc', 'settings')`.

To disable, either `setThirdPartySetting(... 'enabled' => FALSE ...)` or
`$vd->unsetThirdPartySetting('custom_field_sdc', 'settings')->save();` (what the UI does).

## Render mechanism

`hook_entity_view_alter()` (`EntityHooks`): when `enabled` is true and `component` resolves to
a valid SDC, it **replaces** `$build` with:

```php
'component' => [
  '#type' => 'component',
  '#component' => $component_id,
  '#props' => $props,   // Custom Field column values mapped through PropWidget plugins
  '#slots' => $slots,   // filled from other fields on the display
]
```

- Available SDC ids come from `\Drupal::service('plugin.manager.sdc')->getDefinitions()`.
- Required props with empty values abort the swap (normal rendering stays).
- If the `sdc_display` module is enabled and controlling the display, this module defers to it.
- Invalid/malformed components are logged to the `custom_field_sdc` channel and skipped.

## Note on the base formatter

A separate field **formatter** with id `custom_field_sdc`
(`SingleDirectoryComponentFormatter`) is provided by the **parent `custom_field` module**, not
this submodule. This submodule operates at the **view-mode** level via the third-party setting
above.

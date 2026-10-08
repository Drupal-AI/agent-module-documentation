<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Where settings are stored & the plugins report

The module has **no settings page** (`configure: null`). "Configuration" means the per-display
settings you set on an extra field's cog, and they are stored in ordinary display config.

## Storage — regular displays

An extra field placed on a *Manage display* is a component of the `entity_view_display` config
entity. Extra Field Plus saves its settings there:

```yaml
# core.entity_view_display.node.article.default
content:
  extra_field_example_node_label:      # component id == extra_field_<plugin id>
    type: extra_field_example_node_label   # set to the field name so a config schema can validate
    settings:
      link_to_entity: true
      wrapper: h2
    weight: 10
    region: content
```

The submit handler (`extra_field_plus_form_entity_view_display_edit_form_submit`) writes
`['type' => <field_name>, 'settings' => <values>]` into the component. Read/write:

```bash
drush cget core.entity_view_display.node.article.default content.extra_field_example_node_label
```

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$component = $fd->getComponent('extra_field_example_node_label');   // ['type' => …, 'settings' => […]]
$component['settings']['wrapper'] = 'h3';
$fd->setComponent('extra_field_example_node_label', $component)->save();
```

Component id rule: `getExtraFieldComponentId()` prefixes the plugin id with `extra_field_`
(and avoids double-prefixing). So plugin `example_node_label` → component
`extra_field_example_node_label`.

## Storage — Layout Builder

On a Layout Builder display the settings are on the `extra_field_block` **section component**
under `extra_field_plus_settings` (not a display component array). See
[../api/settings.md](../api/settings.md).

## Config schema

Extra Field Plus itself ships no schema; each plugin's settings are validated by a schema keyed
by the field/component name. The example submodule ships
`field.formatter.settings.extra_field_example_node_label` (keys `link_to_entity`, `wrapper`)
as the pattern to follow.

## Plugins report

*Reports → Extra Field Plugins List* → **`/admin/reports/extra_fields`**
(route `extra_field_plus.extra_field_plugins`, permission `administer site configuration`),
controller `ExtraFieldPluginListController::pluginsList`. Lists every discovered extra field
plugin — useful to confirm your plugin registered and to see its id/bundles.

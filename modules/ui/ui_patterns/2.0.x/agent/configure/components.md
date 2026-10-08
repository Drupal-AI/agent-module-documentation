<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring a component (the `ui_patterns` settings array)

Everywhere a component is used (block settings, field-formatter settings, layout
settings, Views style) the configuration is stored under the same `ui_patterns` array.
Shape (confirmed against live config):

```yaml
ui_patterns:
  component_id: 'olivero:teaser'   # the SDC id: "<theme_or_module>:<component>"
  variant_id: ''                    # optional enum "variant" prop value, or ''
  props:
    <prop_name>:
      source_id: <source>           # e.g. textfield, token, select, number
      source: { value: '...' }      # source-specific settings
  slots:
    <slot_name>:
      sources:
        - source_id: textfield      # a slot is a LIST of sources (can nest components)
          source: { value: 'Hello' }
          value: 'Hello'
```

- `props` is a map keyed by prop name; each holds **one** source.
- `slots` is a map keyed by slot name; each holds a **list** of sources (so you can stack
  static text + a nested `component` source + a token in one slot).
- The component's available props/slots come from its `*.component.yml` schema. Inspect one:
  `drush php:eval 'print json_encode(\Drupal::service("plugin.manager.sdc")->getDefinition("olivero:teaser")["slots"]);'`

## Where each surface stores it

| Surface (submodule) | Config entity / structure | Plugin id |
|---|---|---|
| Block (`ui_patterns_blocks`) | `block.block.<id>` → `settings.ui_patterns` | `ui_patterns:<component_id>` |
| Field formatter (`ui_patterns_field_formatters`) | `core.entity_view_display.*` → component `settings.ui_patterns` | formatter `ui_patterns_component` or `ui_patterns_component_per_item` |
| Layout (`ui_patterns_layouts`) | layout config → `settings.ui_patterns` | `ui_patterns:<component_id>` |

Field formatters `ui_patterns_component` (whole field → one component) and
`ui_patterns_component_per_item` (each field item → a component) apply to **all** field
types (widened via `hook_field_formatter_info_alter`).

## Common Source plugin ids (static, non-derived)

`textfield`, `token`, `number`, `checkbox`, `checkboxes`, `select`, `selects`,
`attributes`, `class_attribute`, `component` (nest a component), `entity_field`,
`entity_reference`, `entity_link`, `field_label`, `menu`, `breadcrumb`, `path`,
`list_textarea`, `url`, `wysiwyg`, `block`.
Entity-field sources are derived, id form `entity:field_property:<entity>:<field>:<prop>`.
Full list: `drush php:eval 'print implode("\n", array_keys(\Drupal::service("plugin.manager.ui_patterns_source")->getDefinitions()));'`

## Set a formatter from code

```php
\Drupal::service('entity_display.repository')->getViewDisplay('node','article','default')
  ->setComponent('body', [
    'type' => 'ui_patterns_component_per_item',
    'label' => 'hidden',
    'settings' => ['ui_patterns' => [
      'component_id' => 'olivero:teaser', 'variant_id' => '', 'props' => [],
      'slots' => ['content' => ['sources' => [[
        'source_id' => 'textfield', 'source' => ['value' => 'Hi'], 'value' => 'Hi']]]],
    ]],
  ])->save();
```

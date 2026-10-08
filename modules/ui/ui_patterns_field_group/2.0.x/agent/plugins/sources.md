<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns source plugins

Two UI Patterns 2.x **sources** (`#[Source]` plugins, `extends SourcePluginBase`) that let a
component's slots/props be filled from the field group being rendered. They are selectable in the
component picker (see [../configure/field_group_component.md](../configure/field_group_component.md))
only when the `ui_patterns_field_group` context is present — i.e. inside a `component_formatter`
group. Both are in `src/Plugin/UiPatterns/Source/`.

## `field_group_child` — `FieldGroupChildSource`

```php
#[Source(
  id: 'field_group_child',
  label: 'Field group child',
  description: 'Child of the field group.',
  prop_types: ['slot'],
  context_definitions: [
    'ui_patterns_field_group'          => ContextDefinition('any'),        // group config
    'ui_patterns_field_group:element'  => ContextDefinition('any', required: FALSE), // render array
  ]
)]
```

Fills a **slot** with one of the group's own children.

- `create()` injects `entity_field.manager` and the `entity_view_display` storage.
- `settingsForm()` builds a `select` of the group's `children`. Each option label is resolved, in
  order, from: the field definition's label → the extra-field label → a nested field group's label →
  the raw child name. It loads the group's siblings via
  `entity_view_display` third-party settings to label nested groups.
- `getPropValue()` returns `$element[$this->settings['field_group_child']] ?? []` — the child's
  already-built render array from `ui_patterns_field_group:element`. Output is whatever the field
  formatter produced (core-sanitized); the source does not re-render or raw-print anything.

## `field_group_label` — `FieldGroupLabelSource`

```php
#[Source(
  id: 'field_group_label',
  label: 'Field group label',
  description: 'Label of the field group.',
  prop_types: ['slot', 'string'],
  context_definitions: [
    'ui_patterns_field_group' => ContextDefinition('any'),   // group config
  ]
)]
```

Supplies the field group's **label** as a slot or a string prop.

- `settingsForm()` shows only a static `<em>Field group label</em>` hint, made visible
  (`#access`) when the target prop is a slot.
- `getPropValue()` reads `label` from the group config. Empty or non-scalar → returns `[]` (slot) or
  `""` (string). Otherwise it sanitizes before returning:

  ```php
  $filtered_label = $settings['format_settings']['label_as_html']
    ? Markup::create(Xss::filterAdmin($label))   // admin toggled HTML label on
    : Markup::create(Html::escape($label));      // default: fully escaped
  ```

  Returned as `['#markup' => $filtered_label]` for a slot, or the markup directly for a string prop.
  The label is therefore always escaped by default, and only relaxed to the admin XSS whitelist
  (`Xss::filterAdmin`) when the field group's own `label_as_html` setting is enabled by an
  administrator.

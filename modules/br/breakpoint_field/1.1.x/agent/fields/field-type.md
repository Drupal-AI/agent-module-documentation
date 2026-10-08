<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# breakpoint_field_item — field type, widget, formatter

## Install / enable
`drush en breakpoint_field -y`. Pulls in core `field` + `field_ui`. Nothing else to configure globally — the module has no settings page.

## Field type — `BreakpointItem`
`src/Plugin/Field/FieldType/BreakpointItem.php`, extends `FieldItemBase`.
- Plugin id `breakpoint_field_item`, label "Breakpoints", `default_widget = breakpoint_field_widget`, `default_formatter = breakpoint_field_formatter`.
- `schema()`: one column `value`, `type: text`, `size: tiny`, `not null: FALSE`.
- `propertyDefinitions()`: single string property `value` (label "Breakpoint Group").
- `isEmpty()`: empty when `value` is `NULL` or `''`.
- Stored value is a breakpoint machine id string (e.g. `bartik.wide`), not a media query.

## Widget — `BreakpointWidget`
`src/Plugin/Field/FieldWidget/BreakpointWidget.php`, extends `WidgetBase`, id `breakpoint_field_widget`.
- `defaultSettings()`: `inline => TRUE`, `inline_width => 125`, `breakpoint_group => ""` (the `inline*` keys are declared but not used elsewhere; only `breakpoint_group` is read).
- `settingsForm()`: a `select` `breakpoint_group` whose `#options` come from `\Drupal::service('breakpoint.manager')->getGroups()`. Set this in **Manage form display** (gear icon) per field.
- `settingsSummary()`: shows `Breakpoint group: <group>`.
- `formElement()`: when a group is set, calls `getBreakpointsByGroup($group)` and `array_reverse`s it. For each breakpoint and each `getMultipliers()` value, builds an option keyed by breakpoint id with label `"<multiplier> <label> [<media query>]"`. Renders a `select` `#title` "Breakpoints", `#default_value` = current stored `value` (or `''`). Note: multiple multipliers on one breakpoint overwrite the same `$options[$breakpoint_id]` key, so only the last multiplier's label survives per breakpoint.
- `validate()` (static `#element_validate`): empty value → set to `''`; otherwise the value must match `/^[a-zA-Z0-9_\.]+$/i`, else `setError` "Breakpoint Group must be a text sring no more than 255 characters." (the length is not actually enforced; only the character-class regex is).

## Formatter — `BreakpointFormatter`
`src/Plugin/Field/FieldFormatter/BreakpointFormatter.php`, extends `FormatterBase`, id `breakpoint_field_formatter`.
- `viewElements()`: for each item emits a render array `#type => html_tag`, `#tag => 'p'`, `#value => t('The breakpoint is @group', ['@group' => $item->value])`.
- Output is intentionally minimal; override in a theme/custom formatter if you need `<picture>`/`srcset` or the breakpoint's media query.

## Config schema
`config/schema/breakpoint_field.schema.yml` defines:
- `field.breakpoint_field_item.value` — sequence of mappings each with a `value` string.
- `field.widget.settings.field_breakpoint_group` — mapping with `breakpoint_group` string.

## Operating notes
- The option list depends entirely on breakpoints registered via `*.breakpoints.yml` (theme/core/Breakpoint module). If a field's chosen group has no breakpoints, the widget select is empty.
- Reading in code/Twig: the stored id is `$entity->field_x->value`. To resolve it to a media query, load it via the `breakpoint.manager` service in a preprocess hook.

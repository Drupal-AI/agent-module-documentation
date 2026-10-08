<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (`ui_patterns_field_group.module`)

## Display-form fix

- **`hook_module_implements_alter()`** — moves this module's `form_alter` to the end so its
  `entity_view_display_edit_form` alter runs **after** `field_group`'s.
- **`hook_form_entity_view_display_edit_form_alter()`** — `array_unshift`es
  `ui_patterns_field_group_field_group_field_overview_submit` onto the form's submit handlers so it
  runs first.
- **`ui_patterns_field_group_field_group_field_overview_submit()`** — for each updated group in
  `$form_state->get('field_group')` that has `format_settings`, it looks up the group's formatter
  plugin definition via `plugin.manager.field_group.formatters` and, if the class has a static
  `processFormStateValues()`, calls it on `$group->format_settings` (by reference). This normalizes
  the pattern mapping submitted through `PatternDisplayFormTrait` **before** Field Group saves the
  display. It then writes the corrected state back with `$form_state->set('field_group', ...)`.

## Template suggestions (for themers)

Both fire only when `$context->isOfType('field_group')` and pull `group_name`, `entity_type`,
`bundle`, `view_mode` (and `pattern`, `field` for destinations) from the `PatternContext`.

- **`hook_ui_patterns_suggestions_alter()`** — adds theme-hook suggestions for the pattern rendering
  a field group, from broad to specific:

  ```
  <hook>__field_group
  <hook>__field_group__<group_name>
  <hook>__field_group__<group_name>__<entity_type>
  <hook>__field_group__<group_name>__<entity_type>__<bundle>
  <hook>__field_group__<group_name>__<entity_type>__<view_mode>
  <hook>__field_group__<group_name>__<entity_type>__<bundle>__<view_mode>
  ```

  When a `variant` is set, a parallel set is added with `__variant_<variant>` inserted after `<hook>`.

- **`hook_ui_patterns_destination_suggestions_alter()`** — adds suggestions for a single destination
  (slot) area, incorporating `pattern` and `field`:

  ```
  <hook>__field_group__<group_name>__<pattern>__<field>
  <hook>__field_group__<group_name>__<entity_type>__<pattern>__<field>
  <hook>__field_group__<group_name>__<entity_type>__<bundle>__<pattern>__<field>
  <hook>__field_group__<group_name>__<entity_type>__<view_mode>__<pattern>__<field>
  <hook>__field_group__<group_name>__<entity_type>__<bundle>__<view_mode>__<pattern>__<field>
  ```

  Again mirrored with `__variant_<variant>` when a variant is set.

Use these suggestion names to add a Twig template that overrides how a specific group (optionally
per entity type / bundle / view mode / variant) renders through its pattern.

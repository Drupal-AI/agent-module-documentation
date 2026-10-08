<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter + render hook

## Formatter plugin

`src/Plugin/Field/FieldFormatter/BootstrapLayoutClassesFormatter.php`, extends `FormatterBase`.
`@FieldFormatter(id = "bootstrap_layout_classes_formatter", label = "Bootstrap Layout Classes",
field_types = {"string","text","list_string"})`. No settings.

Select it on the field's **view display** (hide the label). Its effect is to **suppress normal
field output**: `viewElements()` returns a render element carrying only custom keys
(`#css_class`, `#css_target`, `#css_depth`) — these are not standard render keys, so Drupal prints
nothing for the field. The real work of adding classes happens in the hook below, keyed off the
formatter being selected. After switching a field away from this formatter, **clear caches** to
get normal rendering back (per README).

## Where the classes actually come from — `hook_entity_view_alter()`

In `bootstrap_layout_classes.module`:

- `bootstrap_layout_classes_entity_view_alter(&$build, $entity, $display)` scans
  `$display->getComponents()` for any component whose `type === 'bootstrap_layout_classes_formatter'`,
  collects those field names + their settings, and calls `_bootstrap_layout_classes_apply()` per
  field on fieldable entities.
- `_bootstrap_layout_classes_apply(&$build, $field, $settings)`:
  - **boolean** field → uses the field's `on_label`/`off_label` setting as the class source.
  - other fields → for each item value, `explode(' ', $item['value'])` into individual tokens.
  - each token is added as `$build['#attributes']['class'][] = Html::getClass($value)`.

So the chosen/stored classes land on the **rendered entity wrapper** (e.g. the node's outer
element), not on the field markup.

## Safety of the class output (mechanism, not a finding)

Every token passes through `\Drupal\Component\Utility\Html::getClass()` (lowercases, strips/replaces
characters invalid in a class name) before being placed into `#attributes['class']`, and Drupal's
attribute rendering escapes attribute values. The widget's free-text **Custom Classes** box is
therefore constrained to a class-name shape on output — it cannot break out of the attribute or
inject markup. There is no external HTTP, no request- or config-supplied file path, and no SQL in
this module.

## Notes

- The `#css_class` / `#css_target` / `#css_depth` keys set by `viewElements()` are inert (leftover
  from an "entity class formatter" lineage referenced in `hook_help`); the rendering path is the
  `entity_view_alter` hook, not the formatter's return array.
- Because it keys off the formatter being present in the view display, the field must have this
  formatter selected for classes to be applied; the raw stored string is never printed.

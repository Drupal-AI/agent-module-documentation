<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The whole module is one class:
`Drupal\link_target\Plugin\Field\FieldWidget\LinkTargetFieldWidget`, annotated
`@FieldWidget(id = "link_target_field_widget", field_types = {"link"})`, extending core's
`Drupal\link\Plugin\Field\FieldWidget\LinkWidget`. There is no service, no plugin manager, no
new plugin *type* — it is a leaf implementation of core's existing `field_widget` plugin
type. A one-key config schema (`field.widget.settings.link_target_field_widget`, extending
`field.widget.settings.link_default`) validates its widget settings.

## Widget-settings layer (`available_targets`)

- `defaultSettings()` adds `'available_targets' => []` to the parent's defaults.
- `settingsForm()` renders `available_targets` as a `checkboxes` element sourced from
  `getTargets()` (the four hard-coded `_self`/`_blank`/`parent`/`top` options).
- `settingsSummary()` appends either "Available targets: …", "No target options were
  selected." (edge case: a saved-but-all-unchecked array), or "All targets will be
  available." to the widget summary line on Manage form display.
- `getSelectedOptions($default_all = FALSE)` reads the `available_targets` setting and
  returns the filtered label list; if nothing was selected and `$default_all` is `TRUE`, it
  returns all four.

## Form-element layer (per link item)

`formElement()` calls the parent `LinkWidget::formElement()` to get the normal URL/title
inputs, then adds one more:

```php
$element['options']['attributes']['target'] = [
  '#type' => 'select',
  '#options' => ['' => $this->t('- None -')] + $targets_available,
  '#default_value' => $options['attributes']['target'] ?? '',
];
```

`$targets_available` comes from `getSelectedOptions(TRUE)` (defaulting to all four when the
widget setting is empty). Because this select lives at `options.attributes.target` inside the
link item's own form structure, Drupal's field widget submit handling writes the chosen value
straight into that link value's `options` array on save — **no custom `#element_validate` or
`massageFormValues()` override is needed**, and no formatter change is needed either: core's
Link field rendering (`\Drupal\Core\Url` / `LinkGenerator`) already turns any `attributes` key
present in a link's `options` into HTML attributes on the rendered anchor.

## Consequences an agent should know

- Persistent state splits in two places: the **widget setting** `available_targets` lives in
  config (`entity_form_display`); the **per-link chosen target** lives in **entity/field
  data**, not config — it is part of the link's own stored `options`.
- Switching a field's widget away from `link_target_field_widget` does not erase previously
  saved `options.attributes.target` values — they simply stop being editable through this
  widget's dropdown (though the target attribute keeps rendering, since the formatter reads
  `options.attributes` regardless of which widget wrote it).
- The `parent`/`top` option keys are stored and rendered verbatim (not `_parent`/`_top`), so a
  link saved with those choices renders `target="parent"` / `target="top"` — technically
  invalid HTML5 `target` keywords, unlike `_self`/`_blank` which are valid as-is.
- The widget has no dependency beyond core's `link` module; it defines no permissions, no
  Drush commands, and no hooks (there is no `.module` file in the package).

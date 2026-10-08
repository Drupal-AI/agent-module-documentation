<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `exposed_filters` ViewsReferenceSetting plugin

Class `Drupal\viewsreference_filter\Plugin\ViewsReferenceSetting\ViewsReferenceExposedFilters`.
It implements `viewsreference`'s `ViewsReferenceSettingInterface` — it does **not** define a
new plugin type; it plugs into viewsreference's existing `ViewsReferenceSetting` manager.

```php
/**
 * @ViewsReferenceSetting(
 *   id = "exposed_filters",
 *   label = @Translation("Exposed Filters - editor view"),
 *   default_value = "",
 * )
 */
```

## `alterFormField(&$form_field)` — builds the editor widgets

- Loads the referenced view executable (`viewsreference_filter.views_utility::loadView`,
  using the field's `view_name` + `display_id`). If the view can't be loaded the field is
  emptied.
- Turns the field into a `#type => container`, `#tree => TRUE`.
- Adds a checkbox **`vr_exposed_filters_visible`** — title "Show Filters on Page".
- If the display `usesExposed()`, it renders the view's real exposed form and copies each
  exposed handler's widget (`$handler->exposedInfo()['value']`) into the field, stripping
  `#tree/#parents/#array_parents/#name/#processed` and moving `#value` to `#default_value`
  so the editor's submitted values map correctly. So editors literally see the view's own
  exposed filter widgets.

## `alterView(ViewExecutable $view, $values)` — applies at render time

- Pulls `vr_exposed_filters_visible` out of `$values` (default FALSE).
- For the remaining values, matches keys against the display's exposed filter identifiers
  (`$filter['expose']['identifier']`) and keeps only non-empty ones → `$filters`.
- If there are filters and (the exposed form is hidden **or** there is no visitor exposed
  input yet), it forces them via `$view->setExposedInput($filters)` — unless the request
  already carries `viewsreference` exposed input.
- Visibility: when `vr_exposed_filters_visible` is FALSE it forces
  `$view->display_handler->setOption('exposed_block', TRUE)` (hides the exposed form on the
  page); when TRUE it sets `exposed_block` FALSE (shows it).

## Consequences an agent should know

- Empty editor values are ignored, so leaving a widget blank means "don't filter on this".
- With "Show Filters on Page" **off**, the editor's values are fixed and the visitor sees no
  filter form; with it **on**, the visitor can override on the page.
- Only filters that are actually **exposed** on the chosen display appear to the editor.
- The plugin only takes effect once `exposed_filters` is present in the field's
  `enabled_settings` — see [../configure/enable-on-field.md](../configure/enable-on-field.md).

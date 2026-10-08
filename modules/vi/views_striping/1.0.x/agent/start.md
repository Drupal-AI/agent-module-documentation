<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views striping (views_striping) — agent index

Adds `odd`/`even` CSS classes to the rows of a table-style View so a theme can zebra-stripe
them. It ships a Views **display extender** (`views_striping`, title "Row striping") that hands
off to a pluggable **striping type**; two are built in — `alternating` (flip every row) and
`field_value` (flip when a chosen field's value changes).

- Depends on core `views` only. Core requirement `^8 || ^9 || ^10 || ^11`.
- No routes, permissions, drush commands, or config schema. No settings page (`configure` is null).
- Works only for the `table` style and the `views_aggregator_plugin_style_table` style (from the
  contrib `views_aggregator` module). You must define CSS for `.odd`/`.even` yourself.

Solutions:
- **Turn on striping and pick a type for a view** → [configure/striping.md](configure/striping.md)
- **Add your own striping strategy (plugin)** → [plugins/striping_types.md](plugins/striping_types.md)

Key facts:
- Display extender plugin id: `views_striping` (`@ViewsDisplayExtender`), class
  `Drupal\views_striping\Plugin\views\display_extender\ViewsStriping`. Must be enabled globally at
  `/admin/structure/views/settings/advanced` (stored in `views.settings` → `display_extenders`).
- Extender options: `striping_type` (`''` | `alternating` | `field_value`) and, for `field_value`,
  `striping_field`. Stored per display under `display_options.display_extenders.views_striping`.
- Plugin type: **`ViewsStripingType`** — manager service `plugin.manager.views_striping_type`,
  class `Drupal\views_striping\ViewsStripingTypeManager`, plugin dir `Plugin/ViewsStripingType`,
  annotation `Drupal\views_striping\Annotation\ViewsStripingType`, alter hook
  `hook_views_striping_type_info_alter` (info id `views_striping_type_info`).
- Built-in striping types: `alternating` (`Alternating`), `field_value` (`FieldValue`).
- Hooks implemented: `views_striping_help`, `views_striping_preprocess_views_view_table`,
  `views_striping_preprocess_views_aggregator_results_table`.

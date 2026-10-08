<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Layout Builder — agent index

Thin glue that makes every UI Patterns pattern selectable as a Layout Builder layout, mapping
pattern fields to Layout Builder regions. No config, no permissions, no schema, no Drush. Depends
on `ui_patterns` and `layout_builder` (and a layout-discovery module such as `ui_patterns_layout`).
This 1.x release targets the UI Patterns **1.x** API.

- **How the integration works: the hooks, the layout class swap, and the region→field pre-render** →
  [api/layouts.md](api/layouts.md)

Key facts:
- `hook_layout_alter` re-points each `pattern_<id>` layout to
  `Drupal\ui_patterns_layout_builder\Plugin\Layout\PatternLayoutBuilder` and copies its icon.
- `hook_element_info_alter` adds `PatternLayoutBuilder::processLayoutBuilderRegions` (a
  `TrustedCallbackInterface` `#pre_render`) to the `pattern` element to move region content onto the
  pattern's `#<field>` slots.
- `hook_module_implements_alter` forces this module's `layout_alter` to run last.
- Enable and go — patterns appear in the "Add section" layout list; no UI to configure.

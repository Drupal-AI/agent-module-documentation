<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Block Exposed Filter Blocks — agent index

Makes *Advanced → **Exposed form in block*** available on Views **block** displays, so the
exposed filters can be placed as a separate block. No settings form (`configure: null`), no
permissions, no Drush, no config schema of its own. Requires `views` **and** `ctools:ctools_views`.

- **Turn it on for a display, the exact config keys, and placing the block** →
  [configure/exposed-form-in-block.md](configure/exposed-form-in-block.md)

Key facts:

- Display option: `views.view.<view_id>` → `display.<display_id>.display_options.exposed_block: true`
  (only meaningful on displays whose plugin is `block`).
- Resulting block plugin id: `views_exposed_filter_block:<view_id>-<display_id>` (core deriver).
- Mechanism: `hook_views_plugins_display_alter()` replaces the `block` display plugin class with
  `ViewsBlockFilterBlockPluginDisplayBlock extends \Drupal\ctools_views\Plugin\Display\Block`,
  overriding `usesExposedFormInBlock()` → TRUE, `usesExposed()` → `DisplayPluginBase::usesExposed()`,
  and `getLinkDisplay()` → NULL for a missing link display.

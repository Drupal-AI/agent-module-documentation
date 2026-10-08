<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Block Override — agent index

Adds a Views display "Block with overrides" that lets each placed block instance override the view's contextual filters, exposed sort, pager ID, and more-link from the block config form. Depends on core `views`. No permissions, routes, or Drush. Provides a Views display schema.

- **The display plugin, its Allow options, per-block form fields, and how overrides are applied at render** → [configure/display.md](configure/display.md)

Key facts:
- Views display plugin `views_block_override` (`@ViewsDisplay`), extends core `\Drupal\views\Plugin\views\display\Block`.
- Extra `allow` options: `contextual_filter`, `exposed_sort`, `pager_id`, `more_link_text`, `more_link_custom_url` (plus core `items_per_page`). Toggle in *Block settings → Allow settings*.
- Per-block overrides render in `blockForm()`, save in `blockSubmit()` into the block's configuration.
- `preBlockBuild()` applies exposed-sort + pager-ID overrides; `execute()` injects contextual-filter values as view args (multi-value joined with `+`) and sets the custom more-link.
- Config schema: `views.display.views_block_override` (extends `views.display.block`) in `config/schema/`.

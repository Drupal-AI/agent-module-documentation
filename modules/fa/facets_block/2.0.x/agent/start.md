<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Block — agent index

Renders many Facets (and Facets Summary blocks) inside **one** block. Provides a single Block
plugin `facets_block` (admin label "Facets Block"); requires the Facets module. No settings
form/route of its own — you configure it in the block placement form. No permissions, no Drush,
no plugin types.

- **Place the block, its settings keys, config shape, selecting facets** →
  [configure/block.md](configure/block.md)
- **Add/alter entries via `hook_facets_block_facets_alter()`** →
  [hooks/facets-alter.md](hooks/facets-alter.md)
- **Template / theme hook (`facets_block`) and per-facet classes** →
  [theming/theme.md](theming/theme.md)

Key facts: block plugin id `facets_block`; config lives in the `block.block.<id>` config
entity under `settings`: `show_title` (def TRUE), `exclude_empty_facets` (def TRUE),
`hide_empty_block` (def FALSE), `add_js_classes` (def FALSE), `facets_to_include`
(array of `facet_block:<facet_id>` / `facets_summary_block:<facet_id>`).

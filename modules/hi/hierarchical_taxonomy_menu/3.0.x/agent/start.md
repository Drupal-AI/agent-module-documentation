<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hierarchical Taxonomy Menu — agent index

Provides one **Block plugin** (id `hierarchical_taxonomy_menu`, category "Menus") that renders a
taxonomy vocabulary's term hierarchy as a nested, optionally collapsible menu — with term images
and referencing-entity counts. Requires only core `taxonomy`. No global settings page
(`configure: null`), no permissions. You configure it entirely through the block instance.

- **Place & configure the block: all settings keys (vocabulary, depth, collapsible, base term,
  images, counts) + drush example** → [configure/block.md](configure/block.md)

Key facts: block plugin id `hierarchical_taxonomy_menu`; settings live on the block config entity
(`block.block.<id>` → `settings`, schema `block.settings.hierarchical_taxonomy_menu`). Required
setting: `vocabulary`. Notable settings: `max_depth` (0–10 or 100=unlimited), `collapsible`,
`stay_open`, `interactive_parent`, `base_term`/`dynamic_base_term`, `use_image_style`/`image_style`/
`image_width`/`image_height`, `show_count`/`referencing_field`/`exclude_empty_terms`,
`dynamic_block_title`, `hide_block`, `max_age`. Template: `hierarchical-taxonomy-menu.html.twig`.

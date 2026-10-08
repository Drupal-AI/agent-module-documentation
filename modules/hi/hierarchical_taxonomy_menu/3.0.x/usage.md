<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hierarchical Taxonomy Menu provides a configurable block that renders the terms of a taxonomy vocabulary as a hierarchical, optionally collapsible menu, with support for term images and referencing-entity counts.

---

The module ships a single Block plugin (id `hierarchical_taxonomy_menu`, category "Menus"). You place the block (Block layout) and, in its settings, choose the vocabulary to build the menu from; the block then renders that vocabulary's term hierarchy as nested links using its own Twig template and CSS/JS. Rich block settings control the output: `max_depth` (how many sublevels, 0–10 or 100 for unlimited), `collapsible` (collapse by default) with `stay_open` and `interactive_parent`, `dynamic_block_title` (make the block title the current term name), `hide_block` (hide when empty), and `base_term` / `dynamic_base_term` to limit the menu to the children of a chosen term (or the current term's subtree). If the vocabulary's terms have an image field, the block can show an image next to each item, sized via explicit `image_width`/`image_height` or an `image_style`. It can also display a count of referencing entities per term (`show_count` for node or commerce_product, a `referencing_field`, `calculate_count_recursively`, and `exclude_empty_terms` to hide terms with no referencing content). A `max_age` setting controls cache lifetime. All configuration lives in the block's settings (schema `block.settings.hierarchical_taxonomy_menu`); the module has no global settings page and no permissions of its own, and requires only core's Taxonomy module. The HTML is fully themeable via the provided template.

---

- Build a category navigation menu from a taxonomy vocabulary and place it in a sidebar.
- Render a vocabulary's full term hierarchy as a nested, multi-level menu.
- Limit the menu depth to a set number of sublevels with max_depth.
- Make the menu collapsible so users expand/collapse branches.
- Keep the branch of the current taxonomy term open (stay_open) in a collapsible menu.
- Allow parent items to be both collapsible and clickable (interactive_parent).
- Restrict the menu to the children of a specific base term.
- Dynamically scope the menu to the current term's subtree (dynamic_base_term).
- Make the block title match the current taxonomy term's name (dynamic_block_title).
- Hide the block entirely when it would render no items (hide_block).
- Show a thumbnail image next to each menu item using a term image field.
- Size term images with an image style or explicit width/height.
- Display a count of nodes referencing each term next to the menu item.
- Display a count of commerce products referencing each term.
- Count referencing entities recursively down the term subtree.
- Hide terms that have no referencing content (exclude_empty_terms) for a cleaner menu.
- Control the block's cache max-age for freshness vs performance.
- Provide a documentation/knowledge-base category tree menu.
- Build a product-category menu for a commerce catalogue.
- Create a location or region navigation from a geographic vocabulary.
- Theme the menu's HTML via the module's Twig template for a custom look.
- Place multiple instances, each menu built from a different vocabulary.
- Offer a faceted-feeling category browse without a search backend.
- Show a blog-topics menu that highlights the topic of the page being viewed.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Taxonomy Bootstrap Accordion provides a single block that renders one or more taxonomy vocabularies as a Bootstrap accordion — each vocabulary is a collapsible panel whose terms are listed as links inside it.

---

The module defines one block plugin, `taxonomy_menu_block` ("Taxonomy Bootstrap Accordion", in the Menus category). When placing the block you select which vocabularies to include (checkboxes, ordered by vocabulary weight) and choose the Bootstrap version (3, 4 or 5) your theme uses; the block emits the matching accordion markup and data attributes (`data-toggle`/`data-parent` for Bootstrap 3/4, `data-bs-toggle`/`data-bs-parent` for Bootstrap 5). Each vocabulary's terms are loaded via `loadTree()` and rendered as links to the term canonical pages; the term matching the current path gets an `active`/`active-trail` class and its panel is expanded. Output is themed through the `accordion-group` theme hook (template `accordion-group.html.twig`), which you can override. The block sets a `url` cache context and taxonomy list/vocabulary cache tags so it invalidates when terms change. It depends only on core `taxonomy`; the actual Bootstrap CSS/JS must be supplied by your theme (e.g. the Bootstrap base theme). There are no permissions, no config form, and no Drush commands — configuration is entirely per block instance (config schema `block.settings.taxonomy_menu_block`).

---

- Add a sidebar accordion listing all terms of one or more vocabularies as navigation.
- Build a category browser where each vocabulary is a collapsible section.
- Provide a Bootstrap 5 accordion of product categories linking to each term page.
- Provide a Bootstrap 3 `panel-group` accordion for a legacy theme.
- Provide a Bootstrap 4 `card`-based accordion.
- Auto-expand the panel and highlight the term that matches the current page's URL.
- Order the vocabulary panels by adjusting vocabulary weights.
- Include multiple vocabularies in one accordion block.
- Place separate accordion blocks in different regions with different vocabulary selections.
- Give visitors a compact, collapsible way to browse a deep term list.
- Override `accordion-group.html.twig` to customize the accordion markup.
- Reuse the same block on multiple pages with per-page active-term highlighting (url cache context).
- Link each term to its taxonomy term page for filtered/listing views.
- Present a glossary or topic index grouped by vocabulary.
- Expose a documentation section tree as an expandable menu.
- Match your theme's Bootstrap version without extra CSS by picking the version in block config.
- Rely on automatic cache invalidation when terms are added, edited or deleted.
- Create a faceted-looking category menu without installing a Views-based solution.
- Show only selected vocabularies while hiding free-tagging ones.
- Give editors a no-code way to publish a taxonomy-driven navigation block.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Bootstrap Accordion — agent index

One block that renders selected taxonomy vocabularies as a Bootstrap accordion (terms as links).
Depends on core `taxonomy`. No permissions, no config form (`configure` null), no Drush. Bootstrap
CSS/JS must come from your theme.

- **Placing and configuring the block (vocabulary selection, Bootstrap version, theme hook/template)** → [configure/block.md](configure/block.md)

Key facts:
- Block plugin id `taxonomy_menu_block` (admin label "Taxonomy Bootstrap Accordion", category "Menus").
- Config (`block.settings.taxonomy_menu_block`): `vocabs` (list of vocabulary machine names),
  `bootstrap_version` (`3`|`4`|`5`, default `3`).
- Theme hook `accordion-group` → `templates/accordion-group.html.twig`.
- Cache: `url` context; tags `taxonomy_term_list`, `taxonomy_vocabulary:<vid>`, `taxonomy_term_list:<vid>`.

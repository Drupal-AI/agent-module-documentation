<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the accordion block

Everything is configured on the block instance — there is no admin settings page.

## Place the block
Structure → Block layout → *Place block*, choose **Taxonomy Bootstrap Accordion**
(`taxonomy_menu_block`, category *Menus*). Block config form fields:

- **Vocabularies to Include** (`vocabs`, checkboxes) — which vocabularies become accordion panels.
  Options are listed ordered by each vocabulary's `weight`. Only checked vids are stored.
- **Bootstrap Version** (`bootstrap_version`, radios, required) — `3`, `4` or `5`. Controls the
  emitted classes and data attributes:
  - `3`: `panel-group` / `panel panel-default` / `panel-heading` / `panel-collapse`, `data-toggle`/`data-parent`.
  - `4`: `accordion` / `card` / `card-header`, `data-toggle`/`data-parent`.
  - `5`: same as 4 but `data-bs-toggle`/`data-bs-parent`.

Stored as config schema `block.settings.taxonomy_menu_block` (`vocabs`: sequence of strings,
`bootstrap_version`: string; default `3`).

## Rendering behavior
- Each selected vocabulary → one panel; heading is the vocabulary label. Terms come from
  `taxonomy_term.loadTree(vid)` and are rendered as links to `entity.taxonomy_term.canonical`.
- The term whose URL matches the current path gets `active-trail active` classes and its panel is
  expanded (`in` / `aria-expanded="true"`). This is why the block carries a `url` cache context.
- Missing/deleted vocabularies or terms are skipped defensively.

## Theming
Output goes through theme hook `accordion-group` (template
`templates/accordion-group.html.twig`), with variables `taxonomy`, `container_class`, `item_class`,
`header_class`, `body_class`, `data_toggle`, `data_parent`. Override the template in your theme to
change markup. The module ships no Bootstrap assets — your theme must load Bootstrap CSS/JS for the
collapse behavior to work.

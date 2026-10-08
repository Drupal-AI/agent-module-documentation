<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pagerer provides a collection of configurable pager styles that can replace Drupal's core pager globally or per View, built from reusable "preset" configurations.

---

Pagerer lets site builders define any number of pager **presets** (`pagerer_preset` config entities, admin UI at `/admin/config/user-interface/pagerer`). Each preset is a three-pane pager — **left**, **center** and **right** — and each pane can hold one of the built-in **style plugins**: `standard` (like core's pager), `basic` (like Views' mini pager), `progressive` (links to progressively more distant pages, e.g. +10/+20/+100), `adaptive` (adaptive-logic links), or `multipane` (a composite that combines the others). Styles are `@PagererStyle` plugins discovered by the `pagerer.style.manager` plugin manager, and each style's default configuration lives in a `pagerer.style.<id>` config object. A preset can be set as a site-wide replacement for the core pager via `pagerer.settings:core_override_preset`, or selected per view through the `pagerer` Views pager plugin ("Paged output, Pagerer"). Pagerer can also rewrite the pager URL querystring (`pagerer.settings:url_querystring`) to replace the `page` key (e.g. with `pg`), start page numbering at 1 instead of 0, and change comma encoding. It uses standard Drupal pager render/theme classes (`pagerer`, `pagerer_base` themes) so existing CSS keeps working, supports Views AJAX pagers, and exposes a `Pagerer` value object plus the style manager for developers who want to render pagers directly.

---

- Replace Drupal's default core pager site-wide with a richer preset (First/Prev/Next/Last + page ranges).
- Show a compact "Page X of Y" mini pager on list pages using the `basic` style.
- Add "jump ahead" links to distant pages (+10, +20, +100) with the `progressive` style.
- Use `adaptive` logic to show a smart, context-sensitive set of page links.
- Build a three-pane pager: item range on the left, page links in the center, First/Last on the right.
- Create different presets for different sections of the site and apply them per View.
- Select a Pagerer preset as the pager for any View via the "Paged output, Pagerer" pager plugin.
- Display "Items 1–10 of 240" style ranges instead of raw page numbers.
- Change the pager URL key from `page` to something custom like `pg`.
- Make page numbers in URLs start at 1 (one-based) instead of 0 for friendlier links.
- Switch the querystring encoding so multiple pagers use dots instead of encoded commas.
- Customize the text/labels for First, Previous, Next, Last and the page separator/breaker (e.g. `|`, `…`).
- Keep AJAX-enabled Views pagers working while using a custom pager style.
- Provide accessible pagers with configurable screen-reader labels and link titles.
- Preserve existing pager CSS because Pagerer reuses core pager markup classes.
- Offer editors a choice of pre-defined pager looks without touching code.
- Configure how many page links a pager shows (the `quantity` setting) per style.
- Show or hide the "Page N of total" prefix/suffix labels on a pager.
- Render a Pagerer pager programmatically in a custom controller via the style manager.
- Standardize pager appearance across many Views by reusing one preset.
- Migrate a legacy site's custom pager to a configurable, exportable preset.
- Test and preview pager styles on the bundled example page (`/pagerer/example`, from the `pagerer_example` submodule).

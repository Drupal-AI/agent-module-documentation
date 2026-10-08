<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alpha Pagination adds an alphabetical (A-Z) jump menu to the header or footer of a Drupal View, letting visitors filter a listing by the first character of a chosen field.

---

Alpha Pagination provides a Views global-area handler ("Global: Alpha Pagination") plus a companion Views field handler ("Alpha Pagination group") that together render an A-Z (and optional 0-9 / "All") paginator in a View's header or footer. The paginator is driven by a text/string field on the base entity and a single-character glossary contextual filter, so each letter links to the same View page with that letter as the last URL argument. Letters that have no matching content can be shown as inactive or hidden entirely, and every wrapper/list/item/link element accepts custom CSS classes. Link paths and per-link HTML attributes are built from tokens (`[alpha_pagination:path]`, `[alpha_pagination:value]`). It works with any base entity that Views supports — nodes, users, comments, taxonomy terms, media — and ships an optional `alpha_pagination_sample_view` submodule with a working example view. The module depends only on core Views and defines no routes, permissions or configuration forms of its own; all configuration lives on the Views area handler options.

---

- Add an A-Z alphabetic jump menu to the header or footer of any View.
- Build a glossary / directory / index listing that filters by first letter.
- Create an alphabetical staff or user directory from a users View.
- Paginate a node listing by the first character of the node title.
- Paginate against a custom text or string field instead of the title.
- Add A-Z navigation to a taxonomy-term or media listing (uses the `name` field).
- Show 0-9 numeric items individually, or collapse them into a single "#" label.
- Position numeric items before or after the alphabetic letters, with an optional divider.
- Show an "All" item (before or after the letters) that links to the unfiltered View.
- Hide letters that have no matching results, or show them greyed-out as inactive.
- Hide the numeric items entirely when no content starts with a digit.
- Apply custom CSS classes to the wrapper, list, active, inactive, numeric and "All" elements.
- Point pagination links at an arbitrary path using tokens (`[alpha_pagination:path]/[alpha_pagination:value]`).
- Render in-page anchor links (path starting with `#`) instead of navigating to a new page.
- Add custom HTML attributes (id, role, data-*) to each pagination link.
- Support non-Latin alphabets (Arabic, Russian shipped; more via the alter hook).
- Alter the alphabet or numbers array from a module or theme (`hook_alpha_pagination_alphabet_alter`, `hook_alpha_pagination_numbers_alter`).
- Reuse the paginator across all displays of a View, or override it per display.
- Enable the bundled sample view (`alpha_pagination_sample_view`) to see a working example against the article content type.
- Transliterate accented first characters to their base Latin letter for grouping.
- Cache the computed character list per view/display/query for large result sets.

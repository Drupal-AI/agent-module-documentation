<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DSFR Twig Components adds a Twig extension of ready-made DSFR (French State Design System) component functions plus HTML-markup and helper functions usable directly from Drupal templates.

---

The module registers one `twig.extension` service whose `getFunctions()` exposes dozens of Twig functions from static classes in `src/Twig/`. The `dsfr_*` functions (`DsfrComponents`) build complete DSFR components — alerts, badges, buttons, cards, tiles, callouts, notices, accordions, tabs, quotes, links, titles, tags, search bars, tooltips, the FranceConnect button — returning their HTML. `m_*` functions (`Markup`) emit generic tags (`<a>`, `<p>`, `<div>`, `<img>`, `<hr>`, `<button>`), `c_*` and small helpers (`PseudoComponents`) produce documentation/code snippets, and unprefixed helpers (`ExternalTools`) provide utilities such as `limit_string`, `convert_bytes`, `get_media_info`, `calc_image_ratio` and `uniq_id`. Each function is registered with `is_safe => ['html']` and the component templates in `templates/` render content with `|raw`, so these helpers are intended to be fed template-author-controlled, DSFR-oriented content. The module is primarily a building block for the DSFR suite (DSFR Core and other siblings depend on it); it has no settings form and no config of its own. It ships an admin-only demo/reference page at `/dsfr/twig/{slug}` (permission `access administration pages`, menu item under DSFR Core settings) that lists the operational component functions with an AJAX keyword filter, a Prism-based code-highlighting library for that page, and an icon/pictogram catalog (`Resources`) that sibling modules read to generate JSON lists. Depends on core Media, Media Library and Text; supports Drupal 9, 10 and 11.

---

- Enable it as a dependency of DSFR Core to make the DSFR Twig functions available site-wide.
- In a Twig template, render a DSFR alert: `{{ dsfr_alert({'title': 'Heads up', 'text': 'Message', 'type': 'warning'}) }}`.
- Build a DSFR card with `{{ dsfr_card({'title': 'Title', 'text': 'Body', 'url': '/node/1'}) }}`.
- Render a DSFR button and a group of buttons via `dsfr_button()` / `dsfr_buttons()`.
- Emit a DSFR tile linking to a route with `dsfr_tile({'title': ..., 'url': ...})`.
- Produce a DSFR title (`<h1>`–`<h6>`) with `dsfr_title({'title': 'Section', 'type': 3})`.
- Show a DSFR badge, callout, highlight or quote from a template.
- Render a FranceConnect sign-in button with `dsfr_franceconnect()`.
- Build a DSFR search bar with `dsfr_search()` and a tooltip with `dsfr_tooltip()`.
- Render an accordion group (`dsfr_accordions()`) or a tabs group (`dsfr_tabs()`).
- Display DSFR tags, individually (`dsfr_tag()`) or as a group (`dsfr_tags()`).
- Show a time-boxed notice banner with `dsfr_notice({'start': ..., 'end': ..., 'title': ...})`.
- Insert plain HTML tags from Twig with `m_div()`, `m_p()`, `m_a()`, `m_img()`, `m_hr()`.
- Truncate a string for display with `limit_string(text, 60)`.
- Format a byte count as a human-readable size with `convert_bytes(file.size)`.
- Fetch a media item's name, URL, size, MIME and extension with `get_media_info(mid)`.
- Compute the closest DSFR image ratio (16x9, 4x3, 1x1, ...) with `calc_image_ratio(w, h)`.
- Generate a unique DOM id with `uniq_id()`.
- Wrap example code for documentation pages with `c_code(...)` and the Prism `code` library.
- Browse the available component functions on the admin demo page at `/dsfr/twig` and filter them by keyword.
- Use the `Resources` icon/pictogram catalog from a sibling module to generate `icons.json` / `pictograms.json`.
- Provide a consistent DSFR component API to custom themes without hand-writing DSFR markup.

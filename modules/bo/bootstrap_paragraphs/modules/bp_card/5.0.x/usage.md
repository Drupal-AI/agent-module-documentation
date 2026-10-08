<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Paragraphs Card ships a ready-made `bp_card` Paragraph bundle that renders a Bootstrap card — image, title, text and an optional button-styled link — in one of two layouts, plus the Twig template and CSS that render it.

---

The module is **config, one Twig template and one `.install` file**: no services, no plugins, no permissions, no settings form and no configure route. Installing it imports `paragraphs.paragraphs_type.bp_card` and nine field instances. Seven of those have storages of their own: `bp_card_title` (string), `bp_card_text` (string_long), `bp_card_image` (image, uploaded to `card/[date:custom:Y]-[date:custom:m]`, alt required), `bp_card_link` (link), `bp_card_style` (list_string, two layouts), `bp_card_button_style` (list_string, eight Bootstrap `btn btn-*` values) and `bp_link_entire_card` (boolean). The remaining two, `bp_margin` and `bp_padding`, reuse storages owned by the parent `bootstrap_paragraphs` module and are grouped into a collapsed **Styles** `details` group by a `field_group` third-party setting on the form display. Note this bundle has **no** `bp_width`, `bp_background` or `bp_header` field — unlike most bundles in the suite. `bp_card.module` implements only `hook_theme()` (registering `paragraph__bp_card`) and `hook_help()`; `bp_card.install` carries update hooks `bp_card_update_5001` and `_5002`, which retro-fit the button-style, link-entire-card, margin and padding fields onto sites installed before those existed. `paragraph--bp-card.html.twig` branches on `bp_card_style`: `card--large-top` renders the image as a full-width `card-img-top`, while `card--small-left` renders a `row g-0` with a `col-md-4` image beside a `col-md-8` body. In both branches the link becomes a `card-footer` anchor that picks up the chosen `btn btn-*` classes and, when `bp_link_entire_card` is on, Bootstrap's `stretched-link` class so the whole card becomes clickable.

---

- Build a three-across grid of teaser cards on a landing page without hand-coding Bootstrap card markup.
- Give editors a card with a large top image for feature promos.
- Give editors a compact card with a small left image for list-style rows.
- Turn an entire card into one click target by ticking "Link Entire Card" (Bootstrap `stretched-link`).
- Render the card's call to action as a primary, secondary, success, info, light, dark, danger or warning button.
- Render the card link as a plain text link by leaving Card Button Style empty.
- Add vertical rhythm around a card using the shared `bp_margin` values (`mt-3 mb-3`, `mt-5`, `mb-1`, …).
- Add internal spacing to a card using the shared `bp_padding` values (`pt-3 pb-3`, `pt-5`, …).
- Keep spacing controls out of the editor's way — they sit in a collapsed "Styles" field group.
- Require alt text on every card image (the field config sets `alt_field_required: true`).
- Constrain card image uploads to `png gif jpg jpeg`.
- Route card image uploads into dated directories (`card/2026-07`) for tidy file storage.
- Add a new card layout by appending an allowed value to `field.storage.paragraph.bp_card_style` and extending the template.
- Add a brand button style by appending to `field.storage.paragraph.bp_card_button_style`.
- Enable the Card bundle on an existing node paragraphs field by adding `bp_card` to its target bundles.
- Nest cards inside a `bp_columns` paragraph to build a responsive card deck.
- Migrate legacy "promo box" content into `bp_card` paragraphs programmatically.
- Audit which nodes use cards by querying paragraph entities of type `bp_card`.
- Override `paragraph--bp-card.html.twig` in a theme to change the card markup or add a badge.
- Restyle cards site-wide by overriding the `bp_card/bp-card` library from a theme.
- Target one card instance in CSS or JS via its generated `id="card-<paragraph id>"`.
- Swap `options_select` for radio buttons on `bp_card_style` to make the layout choice more obvious.
- Hide `bp_card_button_style` from the form display on sites that want a single button treatment.
- Ship card configuration as exported config so it deploys identically across environments.
- Upgrade an older Bootstrap Paragraphs site and pick up the newer card fields via `bp_card_update_5001`/`_5002`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Paragraphs Card (`bp_card`) — agent index

Submodule of **bootstrap_paragraphs** 5.0.x. Ships **one Paragraph bundle** (`bp_card`, label
"Card") + 9 fields + one Twig template + one CSS library + two update hooks. **No services, no
plugins, no permissions, no Drush, no config schema, `configure: null`.**

- **Bundle id, its 9 fields, allowed values, form/view display, field_group, update hooks,
  how to enable it and create one in PHP** → [configure/card-bundle.md](configure/card-bundle.md)
- **Twig template's two layout branches, emitted markup/classes, `stretched-link`, library
  override** → [theming/template.md](theming/template.md)

Key facts:

- Bundle: `bp_card`. Config: `paragraphs.paragraphs_type.bp_card` (in `config/optional/`).
- **Own storages (7):** `bp_card_title` (string), `bp_card_text` (string_long),
  `bp_card_image` (image), `bp_card_link` (link), `bp_card_style` (list_string, 2 values),
  `bp_card_button_style` (list_string, 8 values), `bp_link_entire_card` (boolean).
- **Shared with the parent module (2):** `bp_margin`, `bp_padding` — both `list_string`,
  9 values each, grouped in a collapsed `field_group` "Styles" details element.
- **This bundle has NO `bp_width`, `bp_background` or `bp_header`** — a real difference from
  `bp_callout` / `bp_media`.
- All list values **are literal CSS class strings** (`card--large-top`, `btn btn-primary`,
  `mt-3 mb-3`).

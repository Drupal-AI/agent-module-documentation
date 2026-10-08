# USWDS Cards — agent index

Submodule of [uswds_paragraph_components](../../../../3.1.x/agent/start.md). Requires
`uswds_paragraph_components_breakpoints`. Installs card-group + card-item paragraph types. No settings
page, no permissions. Hooks in `src/Hook/UswdsParagraphComponentsCardsHooks.php`.

## Paragraph types & fields (config/optional)

Expose the two **group** bundles; the item + breakpoint bundles are children.

- **`uswds_card_group_regular`** / **`uswds_card_group_flag`** (containers):
  - `field_cards` — nested card items (`uswds_card_regular` / `uswds_cards_flag`).
  - `field_uswds_classes` — term reference (`uswds_classes` vocab); term title added as a CSS class.
  - `field_alternating_flags` (flag group only) → alternate media side per row.
- **`uswds_card_regular`** (item): `field_card_title`, `field_text` (text_long), `field_card_image`
  (media ref), `field_button` (link), `field_make_card_link` (bool), `field_card_breakpoints`
  (nested `uswds_card_breakpoints`), `field_title_first`, `field_indent_media`, `field_extend_media`.
- **`uswds_cards_flag`** (item): same core fields plus `field_image_position` (left/right); no
  title-first / indent / extend.
- Also installs media type **`image`** (`field_media_image`) and taxonomy **`uswds_classes`**.

## Rendering & assets

Theme hooks: `paragraph__uswds_card_group_regular`, `paragraph__uswds_card_group_flag`, and a
`regular_cards` template. Templates build `usa-card-group` > `usa-card`(`--flag`) markup. Responsive
columns: each `field_card_breakpoints` row's `field_uswds_breakpoints` term name + `field_number_of_columns`
→ `grid-col-N` (mobile) or `<term>:grid-col-N`; empty → default `grid-col-6`. `field_make_card_link`
wraps the card in the `field_button` URL. CSS shim `uswds_paragraph_components_cards/uswds-cards`
attached in `hook_preprocess_paragraph()` when `view_mode !== 'preview'`.

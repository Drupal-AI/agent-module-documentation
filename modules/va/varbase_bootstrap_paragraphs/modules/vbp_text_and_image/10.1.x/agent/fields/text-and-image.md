# The `text_and_image` paragraph bundle

Installed as optional config (`config/optional/`). One bundle, `text_and_image` ("Text and image"),
with `allow_library_conversion: true` (can be saved to Paragraphs Library). Content is authored by
users with the standard Paragraphs permissions.

## Own fields

| Field | Type | Meaning |
|---|---|---|
| `field_text_content` | `text_long` | The formatted (WYSIWYG) text column. |
| `field_image` | entity_reference → `media` | The image column (a media entity). |
| `field_image_position` | `list_string` | `left` or `right` — which side the image sits on. |
| `text_and_image_style` | `list_string` | Column ratio: `paragraph--style--50-50` (½/½), `--75-25` (¾/¼), `--66-33` (⅔/⅓), `--25-75` (¼/¾), `--33-66` (⅓/⅔). |

## Reused parent styling fields

Also carries the parent's shared fields, honored by the parent's `hook_preprocess_paragraph`:
`bp_background`, `bp_gutter`, `bp_width`, `bp_classes`, `bp_title`, `bp_title_status`,
`bp_image_field`. Behavior is identical to the parent — see
[../../../../../10.1.x/agent/theme/styling.md](../../../../../10.1.x/agent/theme/styling.md).

## Rendering (`templates/paragraph--text-and-image.html.twig`)

- Attaches `varbase_bootstrap_paragraphs/vbp-default`, `.../vbp-colors`, and this module's
  `vbp_text_and_image/vbp_text_and_image_default` (`css/default.css`).
- Maps `text_and_image_style` to two Bootstrap column classes — e.g. `--50-50` → `col-lg-6` +
  `col-lg-6`, `--75-25` → `col-lg-9` + `col-lg-3`, `--66-33` → `col-lg-8` + `col-lg-4`, etc. (`col_1`
  is the image side, `col_2` the text side).
- `field_image_position` sets ordering/alignment classes: `left` → image `order-1`/`align2left`,
  text `order-2`/`align2right`; otherwise mirrored.
- Applies the same background/width/gutter/title/custom-class handling as the parent default
  template (title `|striptags`, custom classes `|striptags` + `|clean_class`), then prints
  `field_image` and `field_text_content` in the two columns.

## Extending

No API — to change the layout, override `paragraph--text-and-image.html.twig` in your theme, or add
values to `text_and_image_style` / `field_image_position` field storage and handle them in the
template.

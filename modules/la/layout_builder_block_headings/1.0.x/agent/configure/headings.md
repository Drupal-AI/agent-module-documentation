<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — layout_builder_block_headings

## 1. On the block-content **type** edit form
Under **Custom block heading settings** (third-party settings, `config/schema/layout_builder_block_headings.schema.yml`):
| Setting | Purpose |
| --- | --- |
| `heading_field` | The field whose value becomes the block heading text. |
| `heading_level_field` | Field (e.g. an Options list) holding the default heading level. |
| `allow_heading_level_customization` | Let editors override the level per Layout Builder placement. |
| `heading_style_field` | Field holding the default heading style. |
| `allow_heading_style_customization` | Let editors override the style per placement. |

Saved by `_layout_builder_block_headings_block_content_type_edit_form_submit()`.

## 2. On the block form
`_layout_builder_block_headings_add_states()` adds `#states` so the level/style fields show only when the heading field is filled.

## 3. In Layout Builder (add/update block)
When customization is allowed, a **Heading Settings** details element exposes:
- `override_heading_level` + `heading_level` (options from the level field's `allowed_values`).
- `override_heading_style` + `heading_style` (options from the style field's `allowed_values`).
Heading text itself is shown disabled (managed on the block, not at placement).
Values are stored on the component via `_layout_builder_block_headings_validate_block_form()` and surfaced through the `SectionComponentBuildRenderArrayEvent` subscriber.

## 4. Rendering (`hook_preprocess_block`)
- Heading built as `#type => processed_text` using the field value + format.
- Effective level = override (if allowed & set) else the field value; anything not in `h1..h6` falls back to `h2`.
- Effective style added as a class via `Html::getClass()` on `title_attributes`.
- Theme suggestion `block__layout_builder_block_headings_block` allows template overrides.

# field_group_background_image — configure

Configured entirely inside **Field Group** on an entity's **Manage display** (view context).
There is no module settings page.

## Enable
1. Add a field group (Field Group module) on Manage display.
2. Set the group's **Format** to **Background Image**.
3. Open the group's format settings (gear) and configure the keys below.

If the entity/bundle has **no image or media-reference field**, the settings form shows
"Please add an image field to continue."

## Settings (`background_image` formatter)
| Setting | Type | Effect |
|---|---|---|
| `image` | select | The source field — any core `image` field, or an `entity_reference` field whose `target_type` is `media`. Required for anything to render. |
| `image_style` | select | Image style to apply; empty = original file. |
| `color_field` | select | Only shown if contrib `color_field` module is enabled; a `color_field_type` field emitted as `background-color` (rgba when the value has `opacity`). |
| `inline_styles` | textfield (≤255) | Extra CSS appended verbatim to the `style` attribute (e.g. `background-size: cover; background-position: center;`). |
| `hide_if_missing` | checkbox | If set and the selected field has no image, the whole group is hidden (`hide()`). |
| `id` | (group setting) | Emitted as the div's HTML `id` (run through `Html::getId`). |

Config schema:
`config/schema/field_group_background_image.field_group_formatter_plugin.schema.yml`.

## Rendering behaviour (`preRender`)
- Group renders as `#type => container` with class `field-group-background-image` (+ the
  group's own classes).
- Builds `background-image: url('<url>')` from the resolved file/media image URI; URL is made
  relative via `file_url_generator`.
- For media fields it loads the `Media` entity and uses its first non-thumbnail `image`
  field's file URI.
- `inline_styles` and the color field's `background-color` are appended after the
  background-image declaration.
- If no valid image URL is produced and `hide_if_missing` is on, the element is hidden.

## Notes
- `inline_styles` is written straight into the inline `style` attribute (admin-configured,
  Manage-display permission) — treat it as trusted admin CSS.

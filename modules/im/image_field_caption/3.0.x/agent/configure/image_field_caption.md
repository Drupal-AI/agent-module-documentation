# Configure

No global settings page — the module has no `configure` route. All configuration is
**per image field**.

## 1. Enable the caption on a field

On the image field's settings (Manage fields → the image field → field settings, i.e. the
`ImageCaptionItem::fieldSettingsForm()` additions), two checkboxes are added:

- **Enable *Caption* field** — setting key `caption_field` (default `FALSE`). When on, the
  edit widget shows a caption `text_format` box for that field.
- **Caption field required** — setting key `caption_field_required` (default `FALSE`).
  Makes the caption mandatory (validated by `_image_field_caption_validate_required`).
- `default_image.caption` — a stored value for the field's default image caption (no visible
  input; kept as a `#type => value`).

These are plain field settings, so in config they live under the field's
`settings:` (e.g. a `field.field.node.article.field_image` config entity):
`caption_field: true`, `caption_field_required: false`.

Known quirk: the "required" checkbox's `#states` visibility references the input name
`settings[image_caption_field]`, but the enable checkbox is actually named `caption_field`
— so the required box does not auto-hide/show as intended. The settings themselves still work.

## 2. Show the caption on display

On **Manage display**, set the image field's format to **"Image with caption"**
(formatter plugin id `image_caption`). It behaves like the core Image formatter (image
style, link settings) but renders the caption beneath the image.

If you leave the format as plain "Image", the caption is stored but not displayed.

## 3. Enter a caption

Editing an entity, each uploaded image shows a **Caption** rich-text area with a text
format selector. Multi-value fields get one caption per image (delta). The caption box is
only accessible once a file is uploaded (`#access` depends on `fids`).

## Theming / CSS

- Template: `templates/image-caption-formatter.html.twig`. Copy it into your theme and
  clear the theme registry (`drush cr`) to customise. Available var: `caption` (a
  `processed_text` render array), plus the core image formatter vars (`image`, `image_style`,
  `url`).
- Default markup wraps the caption in `<blockquote class="image-field-caption">…</blockquote>`.
- Style with the CSS selector `blockquote.image-field-caption`.

## What it does NOT provide

No permissions, no Drush commands, no config schema, no settings form. Uninstalling drops
the `image_field_caption` / `image_field_caption_revision` tables (via core module uninstall
of `hook_schema` tables).

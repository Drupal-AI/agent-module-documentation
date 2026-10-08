# Configuration

Image Field Caption has no global settings page. You configure it per image field
in three short steps: turn the caption on for the field, choose the caption
formatter on the display, and enter a caption when editing content.

## 1. Enable the caption on a field

1. Go to **Structure → Content types → *(your type)* → Manage fields** (or the
   Manage fields page of whatever entity type carries the image field).
2. Open the settings for the image field.
3. You'll find two new checkboxes:
   - **Enable *Caption* field** — turns the feature on for this field. When
     checked, the edit form shows a rich-text caption box for each image.
   - **Caption field required** — makes the caption mandatory, so editors can't
     save without filling it in.
4. Save the field settings.

> **Known quirk:** because of a naming mismatch in the module's form, the
> "Caption field required" checkbox does not automatically show or hide based on
> the enable checkbox. Both settings still work correctly — it's only the
> show/hide behavior that's affected.

There is also a `default_image.caption` value that stores a caption for the
field's default image; it has no visible input and is managed internally.

## 2. Show the caption on display

1. Go to the matching **Manage display** page for the entity/bundle.
2. For the image field, set the format to **Image with caption**.
3. Save.

This formatter behaves just like the core Image formatter — you still get the
image-style and link options — but it renders the caption beneath the image. If
you leave the format as plain **Image**, captions are stored but never shown.

## 3. Enter a caption

When editing an entity, each uploaded image now shows a **Caption** rich-text area
with a text-format selector, so captions can include links, emphasis, and other
allowed markup. Notes:

- Multi-value image fields get one caption per image.
- The caption box only becomes available once a file has actually been uploaded.

## Theming and CSS

The default markup wraps the caption in
`<blockquote class="image-field-caption">…</blockquote>`, so you can style it with
the CSS selector `blockquote.image-field-caption`.

To change the markup itself, copy the module's template
`templates/image-caption-formatter.html.twig` into your theme and rebuild the
cache (`drush cr`). The template receives a `caption` variable (a processed-text
render array) alongside the usual core image formatter variables (`image`,
`image_style`, `url`).

## For developers

Captions can be read and written programmatically through the
`image_field_caption.storage` service (methods such as `getCaption()`,
`isCaption()`, `list()`, and `clearCache()`). See the
[`agent/`](../agent/start.md) docs for the storage API and value shapes.

# Image Field Caption — manual setup guide

**Image Field Caption** (`image_field_caption`) adds an optional, rich-text
caption to Drupal's core image fields. Editors type the caption per image right in
the entity edit form, and a dedicated "Image with caption" formatter renders it
neatly beneath the image on display.

Rather than inventing a new field type, the module extends the image field you
already have. It adds a couple of per-field settings, injects a formatted-text
caption box into the image widget (with a text-format selector, so captions can
carry links and emphasis), and ships a display formatter that wraps the caption in
a `<blockquote class="image-field-caption">`. Because it builds on the core image
field, it works on any fieldable entity — nodes, media, taxonomy terms, users,
paragraphs — and it plays nicely with image styles.

One design detail worth knowing: caption text is **not** stored in the image
field's own columns. The module keeps captions in its own database tables, keyed
by entity, field, language, and image delta, and merges them back into the image
values when the entity loads. That means enabling it doesn't alter your image
field's schema, and multi-value image fields get one caption per image.

There is no global settings page — everything is configured per image field on
the field's settings and display pages. The module adds no permissions, Drush
commands, or config of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable captions on a field, choose
   the formatter, and enter a caption.

## Where it lives in the admin menu

Image Field Caption has **no admin settings page**. You configure it per field
under **Structure → Content types → *(your type)* → Manage fields** (the image
field's settings) and **Manage display** (choosing the "Image with caption"
formatter).

## How to use it

1. On your image field's settings, turn on **Enable *Caption* field**.
2. On **Manage display**, set that field's format to **Image with caption**.
3. Edit a piece of content, upload an image, and fill in the **Caption** box that
   now appears.

See [Configuration](configuration/index.md) for each step in detail, plus theming
and CSS.

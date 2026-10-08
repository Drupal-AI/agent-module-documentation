# Configuration

Grout Image is configured in three layers: a **site‑wide settings page** for the
defaults, a **field formatter** you set per field, and optional **Twig helpers** for
template authors. This page covers all three.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Grout Image**, or navigate directly to
   `/admin/config/media/grout-image`.

## Site‑wide defaults

The settings page holds the defaults used whenever a formatter doesn't override
them:

- **Grout API base URL** — defaults to `https://grout.in`. Change this only if you
  run a self‑hosted Grout instance.
- **Default avatar size** — the square size, in pixels, for generated avatars.
- **Background colour** — the default background for generated images (a hex colour).
- **Text colour** — the default colour of the initials or text drawn on the image.
- **Image format** — the default output format (`png`, `jpg`, or `webp`).

These apply everywhere unless a specific field formatter overrides them. Click
**Save configuration** when done.

## The "Grout Fallback" field formatter

The formatter is what puts fallback images on your content:

1. On a content type (or media type) that has an entity‑reference field pointing to
   media entities, go to **Manage display**.
2. Set that field's formatter to **Grout Fallback**.
3. In the formatter settings:
   - **Fallback type** — choose **Avatar** (initials) or **Placeholder** (solid
     colour).
   - **Image style** — the fallback is generated to match the output dimensions of
     the image style you pick, so the layout doesn't shift. For crop/resize styles
     (e.g. *Scale and Crop*) the exact pixel dimensions are used; for scale‑only
     styles the configured maximum dimension is used as a bounding box.
   - **Background colour**, **text colour**, and **image format** — optional
     overrides of the site‑wide defaults.
   - **View mode** — the view mode used to render the *real* media entity when the
     field is populated.

When the field has an image, the real media is shown; when it's empty, a
Grout‑generated avatar or placeholder appears in its place.

## Twig helpers

Once the module is enabled, two helpers are available in any Twig template:

- The **`grout_avatar`** filter builds an avatar URL from a name (pass the entity
  label). Options include `size`, `background`, `color`, `rounded`, `bold`, and
  `format` — each falling back to your site‑wide defaults.

  ```twig
  <img src="{{ node.label|grout_avatar({size: 200, rounded: true}) }}" alt="{{ node.label }}">
  ```

- The **`grout_placeholder`** function builds a placeholder URL from a width and
  height, with optional `text`, `bg`, `color`, and `format`.

  ```twig
  <img src="{{ grout_placeholder(300, 450, {text: node.label, bg: '1a1a2e'}) }}" alt="{{ node.label }}">
  ```

Colours are given as hex values without the leading `#`.

## Overriding defaults in settings.php

The site‑wide defaults can also be overridden from `settings.php` using the
`grout_image.settings` configuration keys (for example, `base_url`), which is handy
for setting a self‑hosted base URL per environment without changing exported
configuration.

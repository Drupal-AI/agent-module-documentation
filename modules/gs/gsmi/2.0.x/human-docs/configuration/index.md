# Configuration

Setting up Generate Social Media Image is a three‑step flow: build an image style
that draws the text, tell the module which style and field to use, then reference
the generated image with a token.

## 1. Create a text‑overlay image style

1. Go to **Configuration → Media → Image styles** and add a new style (or edit an
   existing one).
2. Add the **Text overlay** effect (provided by the Image Effects module).
3. In the overlay's text, use **node tokens** such as `[node:title]`. These are the
   placeholders the module replaces with each node's real data when it generates
   the image. You can combine several tokens and static text.
4. Make sure the effect points at your installed **font file**.

The module's `README.md` ships two ready‑made example styles you can import to get
started quickly.

## 2. Choose the style and field on the settings page

1. Go to **Configuration → Media → Generate Social Media Image**
   (`/admin/config/media/gsmi`).
2. Select the node type's **image field** to use as the base picture — for example
   `field_seo_image`.
3. Select the **image style** you built in step 1.
4. A **live preview** appears below the settings, showing the generated image for a
   node you pick — use it to confirm the text and layout look right.

From this page you can also **save the generated image directly as a file or as a
media entity**. Repeated saves update the existing file/media entity rather than
creating duplicates.

## 3. Output the image with a token

Use these tokens — typically in your meta‑tag configuration — to emit the full
path of a node's generated image:

- `[node:generate-style]` — uses the image style and field you selected on the
  settings page.
- `[node:generate-style:STYLE_MACHINE_NAME]` — uses a specific image style.
- `[node:generate-style:STYLE_MACHINE_NAME:FIELD_MACHINE_NAME]` — uses a specific
  image style **and** a specific field.

A common use is to feed `[node:generate-style]` into the `og:image` meta tag so
that social platforms pick up the tailored image.

## How caching and regeneration behave

- **Generated once, served fast.** Each image is written to the public file
  system the first time it is needed and served directly by the web server
  thereafter — no Drupal bootstrap on repeat requests.
- **Automatic invalidation.** When a node is updated, or when these settings
  change, the affected images are regenerated.
- **Stale‑URL redirect.** If a CDN, crawler, or browser requests an old image URL,
  the module redirects to the current image instead of returning a 404.
- **Per‑translation.** Every translation of a node gets its own image, with tokens
  resolved in that translation's language.
- **Manual flush.** `drush gsmi:flush` purges all generated images.

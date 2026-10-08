<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Field Tokens adds Image-field widgets and formatters that let you put entity tokens (and default values) into the Alt and Title text of images, resolving them against the host entity.

---

The module extends core's Image field without adding a field type or any configuration of its own.
It provides a field **widget** `imagefield_tokens` (extends the core `image_image` widget) that
shows a token-tree link and lets editors type tokens such as `[node:title]` into the Alt and Title
fields; a companion widget `imagefield_tokens_widget_crop` appears only when the `image_widget_crop`
module is enabled. For display it provides a field **formatter** `imagefield_tokens` (extends the
core image formatter) that runs `\Drupal::token()->replace()` on the stored Alt/Title text against
the current entity at render time — attaching the proper cache metadata (BubbleableMetadata) so
token-derived values invalidate correctly — plus an `imagefield_tokens_colorbox` formatter that
appears only when the `colorbox` module is enabled. Tokens are stored verbatim in the image item's
`alt`/`title` values and expanded on output (the widget can also preview the replacement). Because
it targets core Image fields it works anywhere an image field is used, including Media, and it
declares itself compatible with FileField Sources and IMCE. It depends on `token`, core `image`,
and `media_library`. There is no settings form, permission, config schema, or Drush command — you
just select its widget on *Manage form display* and/or its formatter on *Manage display*.

---

- Auto-fill an image's Alt text from the node title with `[node:title]`.
- Set a default Title attribute using a token like `[node:field_caption]`.
- Provide consistent, SEO-friendly alt text across many images via tokens.
- Let editors insert tokens through a token-tree link right on the image widget.
- Populate alt/title from a media entity's fields when using Media Library.
- Use `[current-page:title]`-style context in image title text.
- Default missing alt text to a field value so accessibility isn't skipped.
- Combine cropping (image_widget_crop) with token-driven alt/title via the crop widget.
- Render images through Colorbox while still resolving token alt/title (colorbox formatter).
- Keep alt/title in sync with entity fields without manual re-entry on every image.
- Apply brand/campaign tokens to image titles sitewide.
- Fill alt text from a taxonomy term reference token on the host entity.
- Reduce editor effort by pre-filling alt/title, still allowing overrides.
- Ensure token-derived alt/title values cache-invalidate correctly (bubbleable metadata).
- Use tokens in alt/title for programmatically imported images.
- Standardise image metadata for a photo gallery content type.
- Provide accessible defaults for decorative-vs-informative images via tokens.
- Populate alt from the author name or publish date token.
- Integrate token image widgets with IMCE or FileField Sources uploads.
- Migrate hardcoded alt text to token-based values for maintainability.
- Give a consistent title tooltip on all product images from a product field.
- Localize alt/title via tokens that resolve per-language entity fields.
- Set default alt/title on an image field used inside a paragraph or block.
- Avoid a custom formatter just to interpolate entity data into image alt/title.

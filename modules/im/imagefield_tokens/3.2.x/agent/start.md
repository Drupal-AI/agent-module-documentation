<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Field Tokens — agent index

Adds Image-field **widgets** and **formatters** that allow entity **tokens** (and defaults) in an
image's Alt/Title text. No field type, no settings, no config route. Depends on `token`, core
`image`, `media_library`.

- **Select the token widget / formatter on Manage form display & Manage display** →
  [configure/display.md](configure/display.md)
- **How tokens are stored and replaced (widget preview + formatter render), cache metadata** →
  [api/tokens.md](api/tokens.md)

Key facts:
- Widget `imagefield_tokens` (extends core `image_image`); `imagefield_tokens_widget_crop` exists
  **only if `image_widget_crop`** is enabled.
- Formatter `imagefield_tokens` (extends core image formatter); `imagefield_tokens_colorbox` exists
  **only if `colorbox`** is enabled.
- Tokens are typed into the normal Alt/Title fields (a token-tree link is shown) and stored verbatim
  in the image item's `alt`/`title`; the formatter runs `\Drupal::token()->replace()` at render.
- No permissions, no config schema, no Drush, no plugin types defined (it provides plugin
  *instances* of core widget/formatter types).

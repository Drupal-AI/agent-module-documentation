<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enhanced Image Formatter replaces Drupal's default image field formatter with an enhanced version that can generate ALT and TITLE text from tokens, link the image to the entity or to a URL taken from a link field, and (via svg_image) render SVGs.

---

Implemented as a formatter (`EnhancedImageFormatter`) extending svg_image's `SvgImageFormatter`, it re-uses the core `image` formatter id and is swapped in globally through `hook_field_formatter_info_alter()`; the install hook bumps the module weight so this alter runs after svg_image's. The settings form adds a "Tokenized ALT and TITLE" fieldset (two token-supporting textfields plus a token tree) and extends the image-link options with any link fields attached to the same entity/bundle. At render time it token-replaces the alt/title strings with the host entity as context and, importantly, passes the result through `Xss::filter()` before assigning to `#item_attributes`, and sets `#url` from the chosen link field.

Because it takes over the `image` formatter id, once enabled it applies to image fields site-wide; configure the token ALT/TITLE and link target per display in Manage display. The ALT/TITLE token templates are administrator-entered and sanitised, and the values render as HTML attributes escaped by the render layer, so there is no raw output path.

---

- Generate image ALT text from tokens (e.g. node title, field values).
- Generate image TITLE text from tokens.
- Link an image to its host entity.
- Link an image to a URL stored in a link field on the same entity.
- Render SVG images inline (via svg_image).
- Apply dynamic, per-entity alt text across many images at once.
- Improve accessibility with meaningful token-driven alt text.
- Improve SEO with descriptive tokenized image attributes.
- Pick the alt/title token type based on the host entity (term → term).
- Use the token tree helper to discover available tokens.
- Combine image styles with enhanced alt/title output.
- Replace the site-wide default image formatter transparently.
- Keep unreplaced tokens from leaking (clear => TRUE).
- Sanitise token output before it becomes an image attribute.
- Configure alt/title/link per view mode in Manage display.
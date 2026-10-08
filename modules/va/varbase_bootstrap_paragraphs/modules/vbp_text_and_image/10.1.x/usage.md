<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VBP Text and Image is a submodule of varbase_bootstrap_paragraphs that adds one paragraph bundle, `text_and_image`: a formatted-text column next to a media image, with a chosen column ratio and the image on the left or right.

---

The submodule is installed config plus a single Twig template and CSS library — it has no settings, permissions, drush or plugins of its own. Its `text_and_image` bundle carries `field_text_content` (WYSIWYG text), `field_image` (media reference), `field_image_position` (left/right), and `text_and_image_style` (the column ratio, e.g. 50/50, 75/25, 66/33), and it reuses the parent's shared styling fields (background, width, gutter, custom classes, optional heading) via the parent's paragraph preprocess. Enable it when you want a ready text-beside-image layout section; everything else about how it looks and behaves comes from varbase_bootstrap_paragraphs.

---
- Add a text-beside-image content section.
- Put the image on the left with text on the right.
- Put the image on the right with text on the left.
- Choose a 50/50 text-and-image split.
- Use a 75/25 or 66/33 (or reversed) column ratio.
- Pair rich text with a media image.
- Give the section a brand background color.
- Set the section content width or run it edge-to-edge.
- Add a heading above the text-and-image row.
- Wrap the section in a container gutter.
- Add custom CSS classes to the section.
- Save a configured text-and-image block to Paragraphs Library.
- Reuse a text-and-image layout across pages.
- Override the layout by theming `paragraph--text-and-image.html.twig`.
- Enable it only on sites that need this specific layout.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# W3CSS Paragraphs (w3css_paragraphs)

Ships ready-made **Paragraphs bundles** styled with the standalone **W3.CSS** framework
(no jQuery/Bootstrap). The base project installs three paragraph types via `config/optional`
plus a media type; 23 bundled submodules add the richer components (card, hero, tabs,
accordion, slideshow, carousel, columns, etc.). No settings form — you build pages by adding
these paragraphs to entity reference-revisions fields and picking W3.CSS options per paragraph.

- **No configuration route** (`configure: null`). All behavior is config entities + Twig templates.
- Requires `paragraphs`, `entity_reference_revisions`, `field_group` (contrib) and core `media`,
  `media_library`, `link`, `views`, `options`, `text`, `filter`, `image`, `block`, `field`.
- Defines **no** permissions, no Drush commands, no services, no plugin types, no config schema.
- Successor projects (per the module's own notice): the W3CSS theme → **Solo**, this module →
  **Paragraphs Bundles**. Existing sites can keep using this.

## What you'd do

- **Understand the paragraph types + fields it provides** → [fields/paragraph-types.md](fields/paragraph-types.md)
- **Understand templates, the CSS/JS library, and where W3.CSS comes from** → [theme/templates.md](theme/templates.md)

## Key facts (real machine names)

- Paragraph types: `w3css_simple` (Simple), `w3css_image` (Image), `w3css_shared` (w3css Shared, the reusable multi-column/tab container).
- Media type: `w3css_media_image` (source: image); view mode `w3css_media_view_image`, form mode `w3css_media_form_image`.
- Libraries (`w3css_paragraphs.libraries.yml`): `w3css_paragraphs/w3css-paragraphs` (front-end),
  `w3css_paragraphs/w3css-paragraphs-admin-seven`, `w3css_paragraphs/w3css-paragraphs-admin-claro` (admin form styling).
- Front-end template attaches the library and reads the per-paragraph `w3css_display_*` fields into CSS classes.
- Hooks in `w3css_paragraphs.module`: `hook_help` (renders `README.md`), `hook_preprocess_page` (attaches an admin library on admin routes), `hook_theme` (registers the paragraph/field template overrides).
- Free-text option field: `w3css_display_classes` (string, 255) on `w3css_simple` only — lets an editor add arbitrary W3.CSS class names to the container.
- Update hooks `w3css_paragraphs_update_9001`–`9004` in `.install` import/patch field & display config from `config/optional`.

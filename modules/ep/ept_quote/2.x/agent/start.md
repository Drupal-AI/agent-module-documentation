<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Quote (ept_quote) — agent index

A single **Paragraphs bundle** — `ept_quote` — for styled quotes / testimonials, part of the
Extra Paragraph Types (EPT) family. Package **Extra Paragraph Types**. Version **2.x** (installed
2.0.0). Core `^10.1 || ^11 | ^12`. License GPL-2.0-or-later.

- **The bundle, its fields, the styles widget, layouts, and how to operate it** →
  [config/bundle.md](config/bundle.md)

## What it actually is

- Ships **no routes, no permissions, no services, no drush, no submodules, no config schema**.
  It is a config-and-template package plus one field widget subclass.
- Dependencies: **`ept_core`** (design-options settings field, formatter, CSS/JS generation) and
  **`paragraphs`**. The image field is a core **Media** reference, so an **"Image" media type
  must exist** — enforced at install by `ept_quote_requirements()` in `ept_quote.install`
  (severity Error, links to `/admin/structure/media`).

## Structure (from source)

- **Bundle**: `config/install/paragraphs.paragraphs_type.ept_quote.yml` (id `ept_quote`).
- **Fields** (all `config/install/field.field.paragraph.ept_quote.*`):
  `field_ept_title` (text_long), `field_ept_text` (text_long), `field_ept_quote_author`
  (text_long), `field_ept_quote_image` (media/image reference), `field_ept_settings`
  (`ept_settings` — shared EPT design options from ept_core).
- **Form display**: tabbed (field_group) — Content tab (title/text/author/image) + Settings tab;
  `field_ept_settings` uses widget **`ept_settings_quote`**.
- **View display**: image via `media_thumbnail` using image style **`ept_quote_image`**
  (`config/install/image.style.ept_quote_image.yml`); text fields via `text_default`.
- **Widget**: `src/Plugin/Field/FieldWidget/EptSettingsQuoteWidget.php` (`ept_settings_quote`),
  extends ept_core `EptSettingsDefaultWidget`; adds a **"Quote styles"** radios element
  (`persona`, `company`, `persona_with_small_icon`, `with_square_image`,
  `with_frame_and_background_image`; default `persona`).
- **Template**: `templates/paragraph--ept-quote--default.html.twig` — branches on the selected
  style, emits an `ept-quote-<style>` class, and `attach_library`s the matching CSS
  (`ept_quote.libraries.yml`: `persona`, `company`, `persona_with_small_icon`,
  `with_square_image`, `with_frame_and_background_image`). Falls back to `persona`.

## Notes

- No config form of its own. Global colors/breakpoints and the per-paragraph design options
  (margins, padding, borders, background, container width, edge-to-edge) come from **ept_core**.
- Content rendering is standard core: text fields via text formats, the author photo via core
  Media/image style. Selecting/editing a quote is gated by the host entity's normal Paragraphs
  create/edit access — no bypass surface added by this module.

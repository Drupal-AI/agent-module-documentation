<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Title Paragraph ships a reusable "title" Paragraphs bundle (title, subtitle, colour, style classes, titlebar toggle, image) plus Twig templates and CSS that render it as a hero-style page header.

---

Title Paragraph is a Drutopia feature module that installs one Paragraphs type, `title`, together with its fields, form/view displays, two image styles and a small set of Twig templates. The bundle carries a `field_title` and `field_subtitle` (single-line `text` fields whose format is locked to `minimalhtmltitle` via the Allowed Formats module), a `field_image` (image field with alt required, rendered through the `max_650x650`/`max_325x325` image styles), and three presentational controls: `field_style_color` (a `list_string` select limited to nine named colours), `field_style_classes` (a multi-value `list_string` of section modifiers) and `field_style_titlebar` (a boolean toggling a full-bleed titlebar layout versus a project/columnar layout). The module's `.module` only implements `hook_theme()` to register overrides for `paragraph__title`, `field__field_title`, `field__field_subtitle` and `field__field_style_color`; the `paragraph--title` template attaches the `drutopia_paragraph_title/title_paragraphs` CSS library (`styles.css`, compiled from the bundled SCSS). Extra templates cover a `columnar` view mode, a `preview` view mode (node teasers) and a UI Patterns component (`title_paragraph`) that extracts the title paragraph from a body-paragraphs list. There are no routes, permissions, controllers, services or Drush commands — it is pure configuration plus theming. It depends on Paragraphs, Entity Reference Revisions, Allowed Formats, minimalhtmltitle, Drutopia Core and the UI Patterns family. Editors add the `title` paragraph to a content type's Paragraphs field to produce a styled title/hero region.

---
- Replace a plain node title with a styled title-plus-subtitle header.
- Add a hero-style title block backed by an uploaded image.
- Give a page an editable subtitle beneath the main heading.
- Let editors pick one of nine named colour themes for the title area.
- Apply section modifier classes (Main / Large / Light) to the header.
- Toggle between a full-bleed titlebar layout and a project/card layout.
- Set the header background image from the paragraph's image field.
- Render the title paragraph as a UI Patterns component.
- Extract and show only the title paragraph from a node's body-paragraphs list.
- Provide a `columnar` view mode that renders the paragraph as a linked card.
- Provide a `preview` view mode for node teasers (image + subtitle byline).
- Constrain title/subtitle input to the minimalhtmltitle text format.
- Serve title images at consistent sizes via the bundled image styles.
- Reuse one title paragraph type across many content types.
- Keep page headers exportable and consistent as site configuration.
- Override `field--field-title` / `field--field-subtitle` for custom heading markup.
- Style the colour field independently via `field--field-style-color`.
- Combine the title paragraph with other paragraphs in a page body.
- Build a Drutopia site's shared page-header pattern.
- Offer editors a structured alternative to hand-written HTML titles.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Paragraphs ships a ready-made suite of ~15 Paragraph bundles (Simple, Image, Columns, Accordion, Carousel, Tabs, Modal, View, Drupal Block, …) built for the Bootstrap 5 CSS framework, so site builders get a structured page-builder without hand-crafting paragraph types.

---

The module contains **no PHP classes, no services, no plugins, no routes and no permissions** — it is a config + Twig package. Everything it provides is 167 YAML files under `config/optional/`: `paragraphs.paragraphs_type.bp_*` bundle definitions, `field.storage.paragraph.bp_*` / `field.field.paragraph.bp_*.*` field definitions, and matching `core.entity_form_display` / `core.entity_view_display` entries. Almost every bundle carries the same four **shared style fields** — `bp_background` (58 Bootstrap/rgba colour classes), `bp_width` (`paragraph--width--tiny|narrow|medium|wide|full`), `bp_margin` (`mt-*`/`mb-*`) and `bp_padding` (`pt-*`/`pb-*`) — grouped into a collapsible "Styles" `field_group` on the edit form and rendered with the `list_key` formatter so the raw CSS class reaches the template. `bootstrap_paragraphs.module` is 93 lines: a `hook_theme()` that registers the bundle templates, a `hook_help()` that prints README.md, and a `hook_preprocess_paragraph()` that rewrites a `bp_background` value into a Bootstrap 5 `bg-*` class exposed as `bs.background_color`. The Twig templates in `templates/` assemble `paragraph--type--*`, width, background, margin and padding into the wrapper `<div>` classes and `attach_library()` the per-component CSS/JS from `bootstrap_paragraphs.libraries.yml`. Container bundles (Columns, Column Wrapper, Carousel, Accordion, Tabs, Modal) nest other paragraphs through `entity_reference_revisions` fields with explicit `target_bundles` allow-lists. Because the config is `optional`, bundles only install when their dependencies are met, and once installed they are ordinary site config you are free to edit. Seven submodules (`bp_callout`, `bp_card`, `bp_contact`, `bp_media`, `bp_quicklinks`, `bp_statistics`, `bp_webform`) add further bundles on the same pattern.

---

- Give editors a Bootstrap-based page builder without writing a single paragraph type by hand.
- Add a "Simple" rich-text paragraph to a landing page content type in minutes.
- Build multi-column marketing rows with the Columns (Equal) bundle, up to six columns.
- Create an asymmetric 2/3 – 1/3 hero row with Columns (Two Uneven) and `bp_column_style_2`.
- Lay out a 1/4 – 1/2 – 1/4 feature strip with Columns (Three Uneven).
- Ship a collapsible FAQ section using the Accordion + Accordion Section bundles.
- Offer an "Expand All" control on an FAQ accordion via the `bp_accordion_expand` boolean.
- Build a rotating hero carousel with a configurable 1–7 second `bp_slide_interval`.
- Add tabbed product information using the Tabs + Tab Section bundles.
- Pop supplementary content in a Bootstrap modal with the Modal bundle.
- Embed an existing Drupal block (e.g. a menu or custom block) inline with the Drupal Block bundle.
- Embed a View — with display, arguments and pager settings — inside body content via the View bundle and `viewsreference`.
- Place a linked image banner with the Image bundle's `bp_image_field` + `bp_link`.
- Give a section a brand-primary background by setting `bp_background` to `paragraph--color paragraph--color--primary`.
- Constrain a testimonial block to half page width with `bp_width: paragraph--width--narrow`.
- Apply consistent vertical rhythm across a page using the `bp_margin` / `bp_padding` select lists.
- Let a trusted editor paste raw markup through the Blank bundle's `bp_unrestricted` field with a Full HTML format.
- Restrict which bundles an editor may add to a given node field via the paragraphs field's `target_bundles`.
- Nest paragraphs arbitrarily deep with the Column Wrapper bundle's unlimited `bp_column_content_w`.
- Standardise page-section styling across many content types by reusing the same bp_* bundles.
- Override a single bundle's markup by copying `templates/paragraph--bp-image.html.twig` into your theme.
- Load only the CSS/JS a page needs — each template `attach_library()`s just its own component.
- Add extra brand colours by defining the five empty background classes in your own theme's CSS.
- Migrate a WYSIWYG-built site to structured content by mapping old markup onto bp_* bundles.
- Prototype a Bootstrap page layout quickly for a demo or client pitch.
- Extend the suite with Callout, Card, Media, Quicklinks, Statistics or Webform bundles by enabling the submodules.
- Export the installed bp_* config to your own config sync directory and customise it as site-owned config.
- Hide the Accordion Section / Tab Section bundles from top-level fields so they are only used inside their parents.

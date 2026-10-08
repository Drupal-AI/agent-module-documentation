<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite (Visual Layout Suite) is a page-building suite on top of Drupal core's Layout Builder that ships a ready-made library of layouts, block types, collections and media types plus an identifier-based utility-class system, so site builders can assemble landing pages without bespoke development for each component.

---

VLSuite is one project made of **37 submodules**, so adopting it is a decision about a set rather than a single install. The fastest paths are the two setup helpers: enable **`vlsuite_shuttle`** to wire up the base suite (media, blocks, layouts, layout builder, utility classes, icon font, tabs and the headings menu) for a customised install without example entities, or **`vlsuite_demo`** to also install ready-to-use example content and a landing content type — both modules auto-disable themselves once they finish. The suite depends on `layout_builder` and, via Composer, on `layout_builder_restrictions`, `section_library`, `media_library_form_element`, `layout_builder_operation_link` and `entity`; it works best on a **Bootstrap 5** theme because the shipped utility classes are Bootstrap's, but because VLSuite stores abstract *identifiers* and maps them to CSS classes in config (`/admin/config/vlsuite/utility-classes`), you can retune those class strings for any theme after install without editing existing content. Settings live under `/admin/config/vlsuite` behind the `administer vlsuite settings` permission; four extra "advanced" permissions (`use advanced vlsuite utility classes`, `... layout options`, `... slider options`, `... animations options`) let you decide which editors may reach the more delicate appearance controls. When building, editors must place the **`vlsuite_*` block variants** (not core's) so the Appearance, Slider and Animation options appear, and can restyle any block or section live from a floating previewer. Remove `vlsuite_demo`'s example content before launch, and note that per-bundle uninstall validators block removing a piece while content of that type still exists.

---

- Install the suite base fast with `vlsuite_shuttle` (auto-uninstalls after setup).
- Evaluate the suite quickly with `vlsuite_demo` example content, then remove it before launch.
- Build a landing page from the ready-made `vlsuite_landing` content type.
- Assemble pages from one-to-four-column VLSuite layouts with optional top/bottom regions.
- Add tabbed or accordion sections with the layout-tabs submodule.
- Place hero, card, gallery and statement/quote collection blocks.
- Place basic blocks: text, CTA, image, icon, local video, remote video, attachments, webform.
- Embed a YouTube/Vimeo video via the core-oEmbed `vlsuite_remote_video` media type.
- Add an auto-generated in-page anchor menu with the headings-menu block.
- Apply utility classes (spacing, colour, alignment) to any block or section from the editor.
- Preview appearance changes live before committing them via the floating previewer.
- Restyle the whole site by re-mapping utility identifiers to your theme's CSS classes.
- Turn a column layout into a slider/carousel with per-section slider options.
- Add scroll-triggered entrance/exit animations to sections and blocks.
- Use an icon font across components via the `vlsuite_icon_font_icon` field.
- Set a media background on a section or block.
- Duplicate an inline block inside Layout Builder in one click.
- Save reusable sections and full layouts to the Section Library.
- Restrict which blocks are allowed per layout via Layout Builder Restrictions.
- Grant a content-editor role appearance control without letting it touch advanced options.
- Configure per-submodule settings (block, media, modal, icon font, animations) under `/admin/config/vlsuite`.
- Scaffold a custom component module from a library template with `drush generate vlsuite-module`.
- Extend the suite by adding your own layouts or block variants that pick up the same utilities.

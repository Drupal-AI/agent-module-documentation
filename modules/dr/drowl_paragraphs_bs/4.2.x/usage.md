<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A DROWL-ecosystem toolkit that ships a shared Paragraph "settings" field (animations, equal-height groups, custom classes/ID) plus a large set of opt-in Bootstrap 5 Paragraph bundles, each in its own sub-module.

---

DROWL Paragraphs for Bootstrap builds on Paragraphs, Layout Paragraphs, UI Styles (via `ui_styles_paragraphs`), Field Group, Fences and the DROWL Base theme/DROWL Media/DROWL Layouts stack to provide a page-building experience made of Bootstrap-5-styled Paragraph types. The base module itself defines almost no bundle: it provides the `drowl_paragraphs_bs_settings` field type/widget/formatter (per-Paragraph animation and expert-styling options), the shared `field.storage.paragraph.*` field storages that the bundle sub-modules reuse, a single admin settings form (slideshow defaults + breakpoint pixel values), theme suggestions and preprocessing that attach the frontend/admin libraries and apply the stored settings as HTML attributes, and a Drush command to bulk-install the bundle sub-modules. The 23 pre-defined Paragraph bundles (markup, layout, layout with restricted access, view, webform, block content, entity reference, gallery, slideshow, video, card, image, image+text, icon, button, anchor, countdown, score, tabs/accordion, text, and more) are each shipped as a separate sub-module so a site only enables the bundles it needs. Display options are implemented as UI Styles so a child theme can extend or override them. The module is intentionally coupled to the DROWL/Radix Bootstrap 5 ecosystem and expects those dependencies to be present.

---

- Install the base module to get the shared per-Paragraph "settings" field and enable only the bundle sub-modules you need.
- Add scroll/hover animations (animate.css names) to any Paragraph via the `field_settings` widget, with event trigger, viewport offset, delay and duration.
- Group Paragraphs into an "equal height group" so their heights are synced by JS.
- Add expert-only custom CSS classes and a custom HTML `id` to a Paragraph without code.
- Bulk-install every bundle sub-module at once with `drush drowl_paragraphs_bs:install-submodules`.
- Exclude specific bundles from the bulk install with `--exclude=drowl_paragraphs_bs_type_markup,...`.
- Configure global Layout Slideshow defaults (section width, autoplay, arrows/dots, infinite, center mode, visible elements per breakpoint).
- Set the site's medium/large breakpoint pixel values used by the slideshow/responsive behavior.
- Build editor page layouts with Layout Paragraphs using DROWL Bootstrap column layouts.
- Restrict a whole layout (and its children) to selected roles using the "Layout with restricted access" bundle.
- Embed a Drupal View into content with the "View" bundle (with optional contextual argument).
- Embed a Webform into content with the "Webform" bundle.
- Embed a reusable custom block into content with the "Block content" bundle.
- Reference and render another node (in a chosen view mode) with the "Entity reference" bundle.
- Build image galleries with column/masonry layouts and PhotoSwipe zoom via the "Gallery" bundle.
- Present a media slideshow with the "Slideshow" bundle.
- Embed uploaded or remote (YouTube/Vimeo) video with the "Video" bundle.
- Add expert raw-HTML/snippet blocks with the "Markup" bundle (governed by Drupal text-format permissions).
- Show a static location map as an image with overlay text/link via the "Simple map" bundle (no external maps API).
- Provide theme-overridable Paragraph preview placeholders in the Layout Paragraphs builder.
- Extend or restyle any display option by adding UI Styles definitions in a child theme.
- Ship consistent Bootstrap-5 markup across all bundles for a Radix/DROWL Base themed site.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A collection of Paragraphs enhancements from DROWL: a reusable per-paragraph "settings" field plus a global settings form and a family of pre-built paragraph type submodules for page building.

---

The base module adds a `DrowlParagraphsSettingsItem` field type with its own widget and default formatter, letting each paragraph instance carry structured display settings (used heavily by the slideshow/layout paragraphs). An admin settings form at `/admin/config/system/drowl-paragraphs` (permission `access drowl_paragraphs settings`, flagged restrict-access) stores site-wide defaults — for example slideshow layout width, autoplay, arrows/dots, infinite/center mode, and the number of visible elements per breakpoint (sm/md/lg). It builds on Layout Paragraphs, Field Group, Foundation Sites and DROWL Layouts to provide a Foundation-based paragraph page-building experience.

Numerous submodules ship ready-made paragraph types and tooling: `drowl_paragraphs_types` (base types), `drowl_paragraphs_type_layout_slideshow`, `drowl_paragraphs_type_countdown`, `drowl_paragraphs_type_markup`, `drowl_paragraphs_type_score`, `drowl_paragraphs_type_block_content`, `drowl_paragraphs_type_layout_restricted_access`, and `drowl_paragraphs_styles_ui`. The single route is the admin settings form and its one permission is restrict-access; there are no anonymous, mutating, or callback endpoints and no outbound/HTTP calls in the module. Setup is: enable the base module plus the paragraph-type submodules you want, configure defaults on the settings form, and add the paragraph types (and the settings field where needed) to your content.
---
- Add a per-paragraph settings field to control display
- Configure site-wide slideshow defaults centrally
- Set default slideshow autoplay, arrows and dots
- Choose visible slideshow elements per breakpoint (sm/md/lg)
- Enable infinite / center mode slideshows by default
- Build Foundation-based paragraph layouts
- Provide editors ready-made paragraph types
- Add a countdown paragraph type to pages
- Add a raw markup paragraph type
- Add a score/rating paragraph type
- Embed block content as a paragraph
- Restrict access to a layout paragraph section
- Offer a slideshow/carousel layout paragraph
- Manage paragraph styles through the styles UI submodule
- Set the default layout section width for slideshows
- Toggle controls-outside vs inside for slideshows
- Combine Layout Paragraphs with DROWL layouts
- Standardize paragraph display settings across a site
- Give content editors structured page-building blocks
- Store paragraph-level display options as a field value
- Apply responsive background images to paragraphs
- Restrict settings administration to trusted roles
- Extend Paragraphs without bespoke theme code
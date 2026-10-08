<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Slick Entity Reference adds a Field UI display formatter that renders a multi-value entity-reference field as a Slick carousel, showing each referenced entity (rendered in a chosen view mode) as a slide.

---

The module ships one primary field formatter, `slick_entityreference_vanilla` ("Slick Entity Reference Vanilla"), that applies to `entity_reference` and `entity_reference_revisions` fields. On a display (Manage display / `entity_view_display`) you switch a reference field's format to this formatter; it then renders each referenced entity — node, taxonomy term, media, Paragraph, etc. — as a Slick carousel slide using the view mode you pick. The carousel's behaviour (arrows, dots, autoplay, responsive breakpoints, skin, lazy-load) is not configured in this module: it comes from a **Slick optionset** (a `slick` config entity, default id `default`, managed by the Slick module at `/admin/config/media/slick`), which you select in the formatter settings under the `optionset` key. The formatter only appears when the field is **multi-value** (`isApplicable()` requires the storage to be multiple), because a carousel needs more than one item. A second formatter, `slick_dynamicentityreference_vanilla`, does the same for `dynamic_entity_reference` fields when that contrib module is installed. Both extend Slick's `SlickEntityFormatterBase` (built on Blazy), so they inherit its settings: `optionset`, `view_mode`, optional thumbnail/nav optionset, skin, and cache. The module has no settings form, permissions, services, or Drush commands — all configuration is per-field in Field UI.

---

- Turn a multi-value entity-reference field (e.g. "Related articles") into a rotating carousel of full referenced nodes.
- Display a taxonomy-term reference field as a carousel of term pages or teasers.
- Render a Paragraphs field (`entity_reference_revisions`) as a Slick slideshow, one paragraph per slide.
- Build a "Featured content" carousel by referencing curated nodes and rendering them in a teaser view mode.
- Create an image/media carousel by referencing Media entities through a reference field and rendering their thumbnails.
- Show a product's related products as a swipeable carousel on a commerce site.
- Present team-member or profile reference entities as a rotating people carousel.
- Display referenced testimonials as an autoplaying quote slider driven by a Slick optionset.
- Reuse the same referenced entities in different carousels by pairing the field with different view modes per display.
- Apply distinct Slick optionsets (arrows vs dots, autoplay speed, responsive breakpoints) to the same field across view modes.
- Render a "gallery" node's referenced photo nodes as a carousel without writing a Views display.
- Build a homepage hero carousel from a small hand-picked entity-reference field.
- Show a taxonomy landing page's referenced highlighted content as a carousel.
- Turn a `dynamic_entity_reference` field (mixed target types) into a carousel with the dynamic formatter.
- Provide a carousel of referenced events rendered in a compact card view mode.
- Display cross-references between articles as a "You may also like" slider.
- Create a logo/partner carousel from a media-reference field on a Basic page.
- Show a course's referenced lessons as a stepped Slick carousel.
- Present referenced case studies in a full-bleed skinned carousel using a custom Slick skin.
- Combine with lazy-loading (Blazy, inherited) so off-screen slides load their images on demand.
- Swap a boring multi-value reference field's default "Rendered entity" output for a carousel with a single formatter change.
- Give editors a no-code way to make any reference field a carousel just by choosing a view mode and optionset.
- Render referenced blocks or custom content entities as carousel slides.
- Build a vertical or fade carousel of referenced entities by selecting the appropriate Slick optionset.

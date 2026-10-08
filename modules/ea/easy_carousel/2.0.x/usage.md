<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy Carousel builds image/media/text carousels from reusable Carousel and Carousel Slide content entities, placed on the site through four configurable block types (Simple, Bootstrap, Brands, Gallery).

---

Easy Carousel is an entity-driven slider builder, not a field formatter. It defines two custom content entity types: `carousel_item` (labelled "Carousel Slide") for an individual slide, and `carousel` for an ordered collection that entity-references any number of slides. Editors create slides under Content > Slides and carousels under Content > Carousels. Each slide holds one visual source — a referenced Media entity (image, uploaded `video`, or `remote_video` oEmbed from YouTube/Vimeo), a base64-encoded inline image, or an external image URL — plus an optional title, a rich-text description, a link (with target), and styling fields: background color + opacity, title color, description color, and text alignment/position (rendered via a custom `color_widget`). To display a carousel you add one of four block plugins in Block Layout, select the Carousel entity via an autocomplete, and set per-block options. The four blocks map to four Twig templates and four locally bundled JS/CSS libraries: **Simple** (media on top, content below; controls, indicators, autoplay, speed), **Bootstrap** (styled with a customized local Bootstrap 5 build; controls, indicators, autoplay, interval), **Brands** (an infinite marquee for logos; slide width and margin), and **Gallery** (thumbnail gallery; carousel height and thumbnail width). Block configuration is serialized into `drupalSettings.easy_carousel` (JSON-encoded) and read by the vanilla-JS controllers. Remote videos are embedded through a Twig `embed_url()` function that normalizes YouTube/Vimeo URLs into sandboxed iframes. An admin Export/Import pair (routes gated by `administer site configuration`) serializes every carousel and slide to a ZIP for backup or migration — importing first deletes all existing carousels and slides, so it is destructive. Two `restrict access` permissions, `administer carousel` and `administer carousel_item`, gate slide/carousel management; block placement is gated by core's `administer blocks`. No external services or CDNs are used; all slider assets ship inside the module.

---
- Add a rotating hero/banner slider to the front page via the Simple carousel block.
- Show a Bootstrap-styled carousel with prev/next controls and slide indicators.
- Build an infinite auto-scrolling "brands" / partner-logo marquee.
- Create a thumbnail-strip Gallery carousel of product or portfolio images.
- Reuse one Carousel entity across multiple regions or pages by placing several blocks.
- Reference existing Media Library images so slides stay in sync with the DAM.
- Embed YouTube or Vimeo videos as slides with player options (mute, autoplay, loop).
- Include self-hosted uploaded videos as `<video>` slides.
- Add slides via base64 inline images when no file storage is desired.
- Point a slide at an external image URL hosted elsewhere.
- Overlay per-slide title, description, and a call-to-action link on each image.
- Style each slide individually (background color, opacity, text colors, alignment).
- Set autoplay speed/interval and toggle controls and indicators per block instance.
- Configure slide width and spacing for the Brands marquee.
- Configure carousel height and thumbnail width for the Gallery type.
- Let content editors manage slides without touching Block Layout, then swap carousels centrally.
- Back up all carousels and slides to a downloadable ZIP before a migration.
- Restore or clone a carousel set on another site by importing the ZIP (destructive: wipes existing).
- Delegate carousel management to a role by granting `administer carousel` / `administer carousel_item`.
- Translate slide titles and descriptions (entities are translatable).
- Keep slide revisions and revert changes (both entity types are revisionable).
- Open slide links in a new tab, parent, or top frame via the link-target option.
- Present a marketing landing page's testimonials as rotating text slides.
- Unpublish individual slides (status flag) without removing them from a carousel.

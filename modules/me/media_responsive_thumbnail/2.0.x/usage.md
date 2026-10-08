<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Responsive Thumbnail adds a single field formatter, "Responsive thumbnail", that lets any Media-entity-reference field render like an Image field with core's Responsive Image formatter — picking a `responsive_image_style` instead of a plain `image_style`.

---

The module ships one class, `MediaResponsiveThumbnailFormatter`, which extends core's `ResponsiveImageFormatter` (from the `responsive_image` module) and reuses all of its settings (`responsive_image_style`, `image_link`, `image_loading`) and its config schema (`field.formatter.settings.responsive_image`). It registers as formatter id `media_responsive_thumbnail` for `field_types: entity_reference`, but `isApplicable()` restricts it to entity-reference fields whose storage `target_type` is `media`, so it only ever appears as an option on Media reference fields, never on plain entity-reference fields to other entity types. At render time it loads each referenced media entity, reads that media type's *source field* (e.g. `field_media_image` for the core Image media type) and falls back to the media entity's own `thumbnail` field if the source field is empty, then renders that image item through the `responsive_image_formatter` theme hook using the configured responsive image style — exactly like core's Responsive Image formatter does for a plain Image field. It supports linking the rendered image to the referenced content entity (`image_link: content`) or to the media item's own canonical page (`image_link: media`); no admin settings page exists (`configure` is `null`) — everything is configured per field on the entity's **Manage display** screen.

---

- Render a Media entity-reference field ("Featured image") as a `<picture>` element using a responsive image style, instead of a single `<img>`.
- Give an editorial "hero image" media-reference field responsive, art-directed image derivatives per breakpoint.
- Serve appropriately-sized images to mobile vs desktop from a Media Library-picked image without a custom formatter.
- Apply a site-wide responsive image style to every content type's media reference field for consistent responsive markup.
- Show a media thumbnail on a "Team member" entity's photo field, resized per viewport via breakpoints.
- Fall back to a media entity's generated `thumbnail` field when the underlying source field (e.g. a remote-video oembed field) has no image, so something is still displayed responsively.
- Link a responsively-rendered media thumbnail to the node that references it (`image_link: content`).
- Link a responsively-rendered media thumbnail to the media item's own canonical page (`image_link: media`).
- Reduce bandwidth on a magazine-style article's inline image by letting the browser fetch only the derivative matching the reader's viewport.
- Combine with the `narrow`/`wide`-style breakpoint groups shipped by `responsive_image` for a two-breakpoint responsive layout.
- Replace an unstyled `<img>` output from an ad hoc "media thumbnail" formatter with a real `<picture>` element.
- Configure lazy-loading (`loading="lazy"` vs `"eager"`) on a Media reference field's image output via the inherited `image_loading` setting.
- Standardize how product images (as Media entities) are displayed across a catalog view using one responsive image style.
- Use it on a Paragraphs "media" field so paragraph-embedded images render responsively.
- Display a taxonomy term's "term image" media-reference field responsively on a term page.
- Give a user profile's "avatar" media-reference field responsive derivatives instead of a single fixed-size image.
- Show gallery thumbnails responsively where each item is a Media entity reference rather than a raw Image field.
- Swap between a "Responsive thumbnail" and a plain "Media thumbnail" formatter on the same field per view mode (e.g. teaser vs full).
- Reduce Largest Contentful Paint on a landing page's hero media field by serving a smaller derivative to small screens.
- Avoid writing a custom field formatter to bridge the Media module and the core Responsive Image module.
- Apply the formatter to a Media Library-selected field on a Layout Builder block.
- Cover video/audio media types whose thumbnail is the poster/cover image, rendering that thumbnail responsively.
- Configure the formatter identically on multiple view modes (default, teaser, RSS) for consistent responsive output.
- Pair with an image-focused media type's crop-enabled source field so responsive derivatives respect the same crop.
- Ensure accessibility by keeping the underlying `alt`/`title` text from the media's image item intact across responsive derivatives.
- Migrate a legacy plain Image field to a Media reference field while retaining responsive image behavior in the display.
- Provide responsive images for a "related media" entity-reference field without granting a plain image field type.
- Serve a smaller responsive derivative in an autocomplete/preview widget context where a full-size thumbnail would be wasteful.
- Let content editors change only the responsive image style config, not code, to retune breakpoints site-wide.
- Apply per-field-instance settings distinctly, e.g. a card teaser using a narrower responsive style than the full article view.

Submodule of Single Image Formatter that renders only the first value of a multi-valued image field using core's responsive image (breakpoint/art-directed) formatter.

---

Provides one field formatter, `single_responsive_image_formatter` (label "Single responsive image"), that extends core `ResponsiveImageFormatter` and overrides `getEntitiesToView()` to return only the first file item. All responsive-image settings (responsive image style, image link) are inherited, and the config schema reuses `field.formatter.settings.responsive_image`. Requires the core `responsive_image` module. Select it on **Manage display** for an `image` field. No settings page, permissions, or code API of its own.

---

- Show only the first image of a multi-value field using a responsive image style.
- Serve art-directed / breakpoint-specific first images from a gallery field.
- Render one hero image responsively while storing many images on the entity.
- Provide breakpoint-aware `srcset` output for just the primary (first) image.
- Use a responsive image style in teaser view showing a single image.
- Keep field cardinality unchanged while displaying one responsive image.
- Drive a responsive card thumbnail from the first delta of an image field.
- Combine with different view modes: all images elsewhere, first image here.
- Apply responsive styles to the lead photo of a photo-set field.
- Replace a dedicated single responsive-image field with a first-value formatter.
- Show the first product image responsively in a catalog listing.
- Give search results a responsive lead image drawn from a multi-image field.
- Deliver optimized first-image markup for social/preview contexts.
- Standardize a single responsive image across templates without extra fields.
- Fall back to the first image responsively for slideshow/gallery fields.

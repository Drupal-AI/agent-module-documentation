<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Responsive Image Link Formatter is a submodule of Image Link Formatter that adds a field formatter, "Responsive image wrapped within link field", rendering a **responsive** image (core `<picture>`/srcset output) wrapped in a link whose URL comes from a Link field on the same entity.

---

The submodule provides one formatter plugin, `responsive_image_link_formatter` ("Responsive image wrapped within link field"), for `image` fields. It extends core's `ResponsiveImageFormatter` and mixes in the parent module's `ImageLinkFormatterTrait`, so it keeps all responsive-image settings (the **Responsive image style** / breakpoint mappings, plus the core `image_link` "Link image to" option) and additionally lists the entity's Link fields in the `image_link` dropdown. When a Link field is selected, each rendered responsive image's `#url` is set to the same-delta Link field value (delta pairing, identical to the parent). It requires both the parent **image_link_formatter** module and core **responsive_image**, and — because it uses core responsive images — you must have a **responsive image style** configured to select. Like the parent it has no admin page (`configure: null`), no permission, no Drush, and no config schema; everything is set on the entity's Manage display. Use this instead of the parent when the image field should output responsive `<picture>` markup rather than a single image style.

---

- Make a responsive hero image clickable, linking to a URL from a Link field.
- Build a responsive, clickable banner/ad component (image + link) that adapts to viewport.
- Serve art-directed `<picture>` sources and still wrap the image in a custom link.
- Point a responsive promo image at a campaign landing page via a Link field.
- Pair multiple responsive images with multiple links by delta.
- Use in Paragraphs to create responsive image-plus-link promo blocks.
- Open the responsive image link in a new tab using Link Attributes / Link Target.
- Add rel/sponsored attributes to a responsive image link via Link Attributes.
- Link responsive sponsor logos to their sites from a taxonomy or block display.
- Keep breakpoint-based srcset output while adding an arbitrary click-through URL.
- Replace core's "Link image to Content/File" with "link to a URL field" for responsive images.
- Configure per view mode (responsive-linked in full, plain in teaser).
- Wrap a media-referenced responsive image in a link.
- Provide multilingual responsive image links via a translated Link field.
- Display a responsive image gallery where each image links to a different URL.
- Give a featured responsive image a click target distinct from its host node.
- Migrate a responsive image-link setup from a custom template to configuration.
- Combine responsive image styles with clickable behaviour without custom Twig.
- Use on custom blocks (block_content) with image + link fields for reusable responsive ads.
- Ensure the responsive image link honours the Link field's target/rel attributes.

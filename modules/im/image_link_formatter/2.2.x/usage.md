<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Link Formatter adds an image field formatter, "Image wrapped within link field", that renders each image wrapped in a link whose URL comes from a **Link field** on the same entity — turning images into clickable banners/ads pointing at custom URLs.

---

The module provides a single field formatter plugin, `image_link_formatter` ("Image wrapped within link field"), for `image` fields. It **extends** core's `ImageFormatter` (via `ImageLinkFormatterTrait`) rather than duplicating it, so it keeps all the core image-style/image-link options and adds the entity's Link fields to the formatter's existing **"Link image to"** (`image_link`) dropdown. When a Link field is selected in that dropdown, `viewElements()` sets each rendered image's `#url` to the matching Link field value, paired by **delta** (image delta 0 wraps link delta 0, and so on). Because attributes are carried on the Link item's URL, link options from modules like Link Attributes or Link Target (e.g. `target="_blank"`, `rel`) are applied to the image link automatically. It works on any entity with an image field and a link field (nodes, custom blocks, users, taxonomy terms, media, Paragraphs). Configuration is entirely on the entity's **Manage display** (`entity_view_display`) — there is no admin page (`configure: null`), no permission, no Drush, and no config schema of its own. A submodule, **responsive_image_link_formatter**, does the same for core's Responsive Image formatter.

---

- Make a banner image link to a campaign URL stored in a Link field on the same node.
- Build a simple "ads block" (custom block with Image + Link fields) whose image links out.
- Let editors point a promo image at any URL without touching code, via a Link field.
- Wrap a logo image in a link to an external partner site.
- Create clickable hero images that link to landing pages.
- Pair multiple images with multiple links by delta (image 0 → link 0, image 1 → link 1).
- Use with Paragraphs to build repeatable image-plus-link promo components.
- Open the image link in a new tab by combining with Link Target / Link Attributes (`target="_blank"`).
- Add `rel="nofollow"`/sponsored attributes to image links via Link Attributes.
- Link a product thumbnail to an external store URL from a taxonomy term display.
- Turn a user-profile avatar into a link to the user's website Link field.
- Provide multilingual image links by translating the Link field per language.
- Keep image-style rendering (crop/scale) while adding a custom link target.
- Replace the core "Link image to Content/File" with "link to an arbitrary URL field".
- Display a sponsor grid where each image links to the sponsor's site.
- Add clickable call-to-action images inside a Layout Builder block.
- Configure the formatter per view mode (e.g. linked in teaser, plain in full).
- Migrate a D7 image-link setup to D10/11 with the same behaviour.
- Wrap media-referenced images in a link when the image field lives on a media entity.
- Give a "featured image" a click-through URL distinct from the node it lives on.
- Show a gallery of images each pointing to a different external resource.
- Avoid custom Twig/preprocess just to wrap an image in a link.

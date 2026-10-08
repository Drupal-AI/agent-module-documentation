<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Link Attributes extends the core image field's link output so the generated anchor can carry `class`, `target` and `rel` attributes, plus an optional link to an image-style variant.

---

Core's `image` and `responsive_image` field formatters can link an image to its file or to its content, but they emit a bare anchor with no way to add attributes. This module hooks into those two formatters, adding third-party settings on the Manage display form so an editor can turn on custom attributes and set values for `target` (a select of `_blank`/`_self`/`_parent`/`_top`), `class` and `rel`. It also can point the link at an alternate image style instead of the original file. Which attributes are offered is controlled by the site-level config object `image_link_attributes.config`, and the values are rendered through Drupal's `link()` Twig function so they are escaped like any other link attribute. The module ships no PHP classes or plugins — only hooks, two Twig templates and config — so its surface and upgrade risk are small.

---

- Add a lightbox class to linked images so a JS library binds to them.
- Open a linked image in a new tab with `target="_blank"`.
- Add `rel="noopener"` (or `rel="noopener noreferrer"`) to image links that open a new tab.
- Group images into a lightbox gallery via a shared `rel` value (e.g. `rel="lightbox-series"`).
- Bind a gallery script to linked images by class with no template work.
- Add `rel="nofollow"` to outbound image links.
- Make image link markup consistent across every view mode of a bundle.
- Configure link attributes per field display, not globally in a preprocess function.
- Replace a one-off Twig override that existed only to add a single attribute.
- Point a linked image at a specific image-style variant instead of the raw file.
- Give responsive image fields the same custom link attributes as regular image fields.
- Add a tracking or analytics class to image links.
- Style linked images differently from unlinked ones via a class hook.
- Provide a data-driven grouping class for a masonry or gallery grid.
- Support a lightbox module (Colorbox, PhotoSwipe, etc.) without writing custom code.
- Ensure a gallery script finds every linked image, even where a view mode was templated differently.
- Keep link-attribute logic out of hook_preprocess in a custom theme.
- Set which attributes editors may add by editing the site-level `image_link_attributes.config`.
- Show the configured attributes on the Manage display summary line for review.
- Audit and standardize image link attributes across content types.

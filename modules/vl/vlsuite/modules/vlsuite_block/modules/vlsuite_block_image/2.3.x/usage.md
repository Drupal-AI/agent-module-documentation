<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Image places an image as a component, delivered through the suite's responsive image configuration.

---

An image in a layout is not just a file: it needs an alt text, a responsive image style so it is not a desktop-sized file on a phone, and a caption in some designs. This component supplies all three as a block type drawing on `vlsuite_media`.

The responsive part is the one that matters for performance. A landing page is usually image-heavy and usually the page a site cares most about, so serving appropriately sized images is the highest-value thing this component does — and it is the thing a hand-built image block most often skips.

Alt text is the accessibility half. A decorative image needs an empty alt, a meaningful one needs a description, and the distinction is the editor's to make. Whether the field enforces it is worth checking on a site with accessibility obligations.

---

- Place an image in a layout section.
- Serve responsive image sizes.
- Add alt text to a placed image.
- Show a caption with an image.
- Improve landing page performance.
- Select an image from the media library.
- Reuse an image across pages.
- Style image placement with utility classes.
- Distinguish decorative from meaningful images.
- Check alt text enforcement.
- Translate an image caption.
- Place an image beside text.
- Avoid desktop-sized files on mobile.
- Audit images missing alt text.
- Standardise image handling across components.

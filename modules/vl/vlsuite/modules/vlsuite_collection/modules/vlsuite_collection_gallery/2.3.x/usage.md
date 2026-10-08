<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Collection Gallery renders a set of images as a gallery grid.

---

A gallery is a card grid whose content is images, and the differences are all in the details: how the grid handles mixed aspect ratios, whether images open larger, how many load before the fold.

This collection provides those answers. Combined with `vlsuite_modal` an image can open in a dialog; combined with `vlsuite_media`'s responsive images each thumbnail is delivered at thumbnail size rather than full size scaled down.

**That last point is the one that decides whether a gallery is usable.** A twelve-image gallery serving full-resolution files is several megabytes before anything else on the page loads. Verify what the gallery's image style actually produces rather than assuming; it is the single most common performance defect in a gallery implementation.

Accessibility: each image still needs alt text appropriate to its role, and a gallery that opens images in a dialog needs the focus management described under `vlsuite_modal`.

---

- Show a grid of images.
- Build a photo gallery on a landing page.
- Open a gallery image in a lightbox.
- Serve thumbnails at thumbnail size.
- Handle mixed aspect ratios in a grid.
- Limit images loaded before the fold.
- Add alt text to gallery images.
- Verify the gallery's image style.
- Check lightbox focus management.
- Style gallery spacing with utility classes.
- Save a gallery to the section library.
- Show a project's photo documentation.
- Audit gallery page weight.
- Lazy-load gallery images.
- Adapt gallery columns per breakpoint.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Mirador integrates the Mirador viewer, so IIIF images can be examined, compared and annotated in place.

---

IIIF — the International Image Interoperability Framework — is how cultural heritage institutions publish high-resolution images so they can be viewed, deep-zoomed and compared across institutions without downloading them. Mirador is the reference viewer for it, and its distinguishing feature is comparison: two manuscripts from different libraries side by side in one window is the thing IIIF exists to make possible.

For a research collection that is not a nicety. Comparing a page against its counterpart in another library, or a painting against its underdrawing, is the actual work; a viewer that can only show one image at a time makes that work happen in two browser tabs and a notebook.

This submodule embeds Mirador against a WissKI collection's images. `wisski_mirador_block` (which ships the `blockmirador` module) places a viewer as a block.

Practical note: IIIF requires an image server that speaks the IIIF Image API — Mirador is the viewer, not the server. `wisski_iip_image` covers the IIP side. A collection whose images are ordinary files on disk needs that layer before any of this works.

---

- View a high-resolution image with deep zoom.
- Compare two manuscripts side by side.
- Compare images across institutions.
- Examine a painting against its underdrawing.
- Annotate an image in place.
- Embed a IIIF viewer in a record.
- Publish images for external IIIF viewers.
- Avoid downloading large images to compare them.
- Check that a IIIF image server is in place.
- Distinguish the viewer from the image server.
- Support manuscript research workflows.
- Place a Mirador viewer as a block.
- Share a IIIF manifest with another institution.
- Plan an image infrastructure for a collection.
- Audit which images are IIIF-served.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Collection: Gallery (vlsuite_collection_gallery) — agent index

Nested submodule of **vlsuite_collection**. **Image gallery grid**.
Version **2.3.3**. Core `^10.3 || ^11`. Pairs with `vlsuite_media` (responsive images) and
`vlsuite_modal` (lightbox).

**The point that decides whether a gallery is usable:** verify what image style the thumbnails
actually use. A twelve-image gallery serving full-resolution files is several megabytes before
anything else loads — the most common performance defect in gallery implementations.

Accessibility: alt text appropriate to each image's role, plus the focus management described under
`vlsuite_modal` if images open in a dialog.
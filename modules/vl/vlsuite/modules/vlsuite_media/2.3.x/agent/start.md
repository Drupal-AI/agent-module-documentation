<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Media (vlsuite_media) — agent index

Submodule of **vlsuite**. **Media types and displays** for the suite's components.
Version **2.3.3**. Core `^10.3 || ^11`.
Depends on `media`, `media_library`, **`responsive_image`**, `vlsuite`.

`responsive_image` is the substantive dependency: images are delivered at appropriate sizes rather
than scaled in the browser — the biggest single lever on landing-page performance.

Nested: `vlsuite_media_image`, `_document`, `_icon`, `_local_video`, `_remote_video`.

**These are core media types**, so anything else on the site can consume them — an advantage for
consistency, and something to check before deleting one.
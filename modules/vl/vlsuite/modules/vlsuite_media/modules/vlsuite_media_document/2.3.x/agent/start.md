<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Media: Document (vlsuite_media_document) — agent index

Nested submodule of **vlsuite_media**. **Document media type** behind the attachment components.
Version **2.3.3**. Core `^10.3 || ^11`.

Fixes the management problem — one entity per document, findable, replaceable in one place, rather
than uploaded per page and impossible to audit.

**Storage is a media-type-level decision, not a per-file one:** `public://` is reachable by URL
whether linked or not (fine for a brochure); `private://` is served through Drupal with access
checks (the only correct answer for anything with an audience restriction).
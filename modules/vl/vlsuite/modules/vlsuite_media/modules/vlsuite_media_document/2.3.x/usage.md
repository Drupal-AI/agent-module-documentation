<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Media Document defines the document media type behind the suite's attachment components.

---

Documents on a site are usually PDFs, and they are usually managed worse than images: uploaded per page, never replaced centrally, and impossible to audit. A media type fixes the management problem — one entity per document, findable in the library, replaceable in one place.

The properties that matter for documents specifically are the ones an attachment component needs to render: file size and type, so a visitor knows what they are about to download, and a human-readable name distinct from the filename.

The other decision is storage. A document in `public://` is directly reachable by URL whether or not it is linked; one in `private://` is served through Drupal with access checks. For a published brochure the first is right; for anything with an audience restriction the second is the only correct answer, and it is a decision made when the media type is configured rather than per file.

---

- Define the document media type.
- Manage PDFs as media entities.
- Replace a document in one place.
- Find an existing document in the library.
- Show file size before download.
- Show file type before download.
- Give a document a readable name.
- Choose public or private storage.
- Restrict access to a document.
- Audit documents on a site.
- Avoid per-page document uploads.
- Translate document metadata.
- Track which pages link a document.
- Retire an outdated document.
- Standardise document handling.

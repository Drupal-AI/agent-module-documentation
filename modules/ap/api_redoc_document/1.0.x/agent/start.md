<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# api_redoc_document

Embeds Redoc-rendered OpenAPI docs via a `<redoc spec-url>` tag.

- `api_redoc_document_preprocess_page()` attaches library `api_redoc_document/api_redoc_document` site-wide.
- Library loads `redoc.standalone.js` from the jsDelivr CDN (external) — note for strict CSP / offline.
- No routes/permissions/services. Authors embed the tag in a Full-HTML field; Redoc renders client-side.

See [../usage.md](../usage.md).

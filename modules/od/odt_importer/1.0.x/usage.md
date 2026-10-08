<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ODT Importer converts .odt documents to HTML.

---

ODT Importer **converts uploaded .odt (OpenDocument Text) documents to HTML** — extracting a document's
content and turning it into HTML that can populate a field, so authors can import formatted documents. It
depends on core Field and File, in the Fields package.

Use it to import ODT content into Drupal. It is a content-editing/import feature. Data-handling note: it parses
**uploaded documents** (an ODT is a zip of XML) — treat uploads as untrusted input (rely on the parser handling
malformed files) and, since the converted HTML is placed into a field, ensure it flows through a **text format
that sanitizes** before display so imported markup can't introduce XSS. It has no access-control role. Configure
the import on the target field.

---

- Convert .odt documents to HTML.
- Extract document content.
- Populate a field from a document.
- Depend on core Field and File.
- Import formatted documents.
- Serve content editing.
- Parse untrusted uploaded documents.
- Sanitize imported HTML via a text format.
- Guard against imported-markup XSS.
- Have no access-control role.
- Configure the import.
- Handle ODT import.
- Import documents.
- Configure the field.
- Convert ODT.
- Handle the import.
- Import ODT.
- Parse documents.
- Sanitize on display.
- Provide ODT import.

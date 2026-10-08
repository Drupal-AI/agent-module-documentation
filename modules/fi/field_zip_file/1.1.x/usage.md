<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Zip File provides a field type for uploading a ZIP archive that is extracted on save, with zip-bomb detection and forbidden-extension filtering; it can also serve extracted HTML.

---

Field Zip File provides a field for uploading a ZIP archive that the module extracts on save,
making the archive's contents available (it can serve extracted HTML in an iframe, e.g. for hosting a
packaged HTML5 asset or report). Extraction is delegated to Drupal core's `Archiver\Zip` (PHP's
`ZipArchive::extractTo`), and the module adds safeguards: a zip-bomb scanner
(`Selective\ArchiveBomb`) and a configurable forbidden-extension filter, plus a
"bypass content restrictions" permission. It depends on core Field and File and provides its own
permissions.

Restrict the upload field to trusted roles and use the **forbidden-extensions** setting to block
file types you don't intend to host. The bomb scanner and extension filter must be configured;
extraction itself uses core's archiver (the same mechanism core uses for module installs).

---

- Upload a ZIP and extract on save.
- Serve extracted HTML in an iframe.
- Host a packaged HTML5 asset.
- Extract via core's Archiver\Zip.
- Scan for zip bombs.
- Filter forbidden file extensions.
- Gate bypass via permission.
- Restrict uploads to trusted roles.
- Block script/executable extensions.
- Configure forbidden extensions first.
- Depend on core Field and File.
- Provide its own permissions.
- Detect archive bombs before extraction.
- Serve extracted report content.
- Understand extraction risks.
- Limit who can upload archives.
- Avoid hosting untrusted HTML/JS.
- Extract to a per-file folder.
- Use extension filtering as mitigation.

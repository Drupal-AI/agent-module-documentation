<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF to ImageField — agent index

Imports a **PDF** and splits its pages into images stored in an **image field** (page-image gallery/
preview of a document). Depends on core `file`; provides **Drush commands**. Version **1.0.1-rc2**.
Core `^10.3||^11`.

**Operational security:** page rasterisation uses server-side tooling (Ghostscript/ImageMagick) —
known delegate-vuln risk area with untrusted PDFs; keep tooling patched and constrain who may
upload.

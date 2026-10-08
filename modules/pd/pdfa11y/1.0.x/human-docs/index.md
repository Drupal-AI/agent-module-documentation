# PDFa11y — manual setup guide

**PDFa11y** (`pdfa11y`) automatically checks uploaded PDF files for accessibility
problems and reports the results against the media item, so the accessibility of
your documents is visible inside Drupal rather than discovered later by someone
relying on a screen reader. Accessibility work often stops at the HTML boundary —
a site can pass its WCAG audit while its published PDFs have no tag structure, no
document language, and no title. PDFa11y extends the checking inward to the
documents themselves, which are frequently the forms, policies, and reports people
most need.

When a PDF is uploaded through a media form, the module parses it and runs a set of
configurable checks: **Tagged PDF** (a logical structure tree screen readers can
follow), **Document Title**, **Document Language**, and a minimum **PDF Version**.
You can choose whether a failing PDF simply **warns** the editor or is **blocked**
from being saved, and each PDF media item gains an "Accessibility" tab showing its
detailed results. A Drush command lets you batch‑check PDFs you already have.

An important reassurance about your data: **parsing happens locally**, in‑process,
using the `smalot/pdfparser` PHP library. No file is sent to an external validation
service — which matters if your documents are confidential. Permissions are split
sensibly so an editor can be given the ability to see reports and re‑run checks
*without* the ability to weaken which checks are enforced. The maintainer notes the
tool is not a comprehensive audit and is best paired with editor training on
producing accessible PDFs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in
   the PDF parser library), enable the module, and confirm the PHP and core Media
   requirements.
2. [Configuration](configuration/index.md) — the settings form, the permissions,
   and where to read the per‑document reports.

## Where it lives in the admin menu

- Settings: **Configuration → Media → PDFa11y**
  (`/admin/config/media/pdf-accessibility`).
- Guidance: a help page at `/admin/config/media/pdf-accessibility/help`.
- Reports: each PDF media item has an **Accessibility** tab showing its check
  results.

See [Configuration](configuration/index.md) for the details.

# File Upload Secure Validator — manual setup guide

**File Upload Secure Validator** (`file_upload_secure_validator`), often shortened
to FUSV, hardens Drupal file uploads by checking that a file's *real content*
matches the type its extension claims. It uses PHP's `fileinfo` extension to sniff
the actual bytes of every uploaded file and compares that against the MIME type
implied by the filename. If someone renames a PHP script or an executable to
`.txt`, `.jpg`, or `.pdf` to slip it past an extension allow‑list, the mismatch is
caught and the upload is rejected.

The best part is that it works automatically across the whole site. FUSV listens
to core's file‑validation event, so **every** file that flows through Drupal's
validation pipeline — any file field, media upload, or programmatically saved file
— is inspected with no per‑field setup. Each rejection is logged and the user sees
a clear error explaining that the file's real content doesn't match its
extension.

Some legitimate files sniff as a generic or overlapping type — a CSV that PHP
reads as `text/plain`, a DOCX that reads as `application/octet-stream`, an SVG,
a `.po` translation file, a certificate. To keep those from being wrongly
rejected, FUSV consults a configurable list of **MIME type equivalence groups**:
if both the extension's type and the sniffed type belong to the same group, the
file passes. Sensible default groups ship for CSV, XML, SVG, gettext `.po`,
certificates/PKCS, and Office documents, and you can add your own on the settings
form. The module has no other dependencies, requires the `fileinfo` PHP extension,
and defines a single permission that controls who may edit the equivalence
groups.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the validation
algorithm and the service API — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   confirm the `fileinfo` extension, and enable it.
2. [Configuration](configuration/index.md) — the equivalence‑groups settings
   form, the default groups, and how to whitelist a wrongly‑rejected file type.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → File Upload Secure Validator**
(`/admin/config/media/file_upload_secure_validator`). The `fileinfo` extension's
availability is also surfaced on the **Status Report**
(`/admin/reports/status`).

## How to use it

There is nothing to switch on per field. Once the module is enabled, uploads are
validated everywhere automatically. Your only ongoing task is tuning the
equivalence groups when a legitimate file is blocked — see
[Configuration](configuration/index.md).

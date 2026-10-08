# Metadata Sanitizer — manual setup guide

**Metadata Sanitizer** (`metadata_sanitizer`) automatically strips hidden metadata
from files uploaded to your site. Photos routinely carry GPS coordinates, camera
serial numbers, and timestamps; PDFs and Office documents can carry author names
and editing history. That data travels with the file when it is published, often
without anyone realising it — a genuine privacy and PII leak. Metadata Sanitizer
removes it at upload time (and in bulk for existing files) using the battle-tested
**exiftool** binary. Once stripped, the metadata cannot be recovered from the
sanitized file.

It works on any file type exiftool supports — not just images, but PDFs, Office
documents, and more. It sanitizes automatically on upload (a toggle you can turn
off), re-sanitizes on file replacement when the underlying URI changes, and offers
a Drush command for cleaning an existing library of thousands of files in one pass.
It depends only on core's **File** module, but it does require the **exiftool
binary** to be installed on the server. Configuration lives at **Configuration →
Media → Metadata Sanitizer**, gated by a dedicated `administer metadata sanitizer`
permission.

This is a privacy-positive, GDPR/data-minimisation feature: it removes personal
data embedded in files before they are stored or delivered. Under the hood it
invokes exiftool safely (arguments are passed directly, with no shell
interpretation), so file paths cannot be used for command injection. Two optional
submodules integrate it with the Drupal AI ecosystem for AI-assisted configuration
and bulk cleaning.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the exiftool binary, install
   the module with Composer, enable it, and pick the AI submodules if you want
   them.
2. [Configuration](configuration/index.md) — the settings form (automatic
   sanitization, file extensions, timestamp preservation) and the bulk-clean Drush
   command.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Media → Metadata
Sanitizer** (`/admin/config/media/metadata-sanitizer`). Access requires the
**administer metadata sanitizer** permission, which is not granted to any role by
default.

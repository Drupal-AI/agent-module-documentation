# Sophron — manual setup guide

**Sophron** (`sophron`) gives Drupal a richer, standards-based **MIME-type map**: a
much more complete table of which file extensions correspond to which MIME (media)
types, and back again. It does this by wrapping the well-maintained
[**FileEye/MimeMap**](https://github.com/FileEye/MimeMap) PHP library, so Drupal can
recognise far more file formats — and less common ones like AVIF or HEIC — than
core's built-in list manages on its own.

Be honest about what Sophron is: it is a **foundation / support module**, not a
feature you switch on and see. On its own it changes very little that a site visitor
would notice. Its value is as a **building block** that other modules depend on —
for example [File Metadata Manager (File MDM)](https://www.drupal.org/project/file_mdm)
and various media- and file-handling modules use it to detect and validate file
types accurately. Sophron exposes a `MimeMapManager` service that developers call
from code, and it ships an optional **`sophron_guesser`** submodule that replaces
Drupal core's extension-based MIME guesser site-wide so uploads and file handling
everywhere benefit from the better mapping.

This guide is written for a **human** clicking through the admin UI. It covers
installing the module and walking through its one settings page. If you are looking
for terse, token-cheap references for an AI coding agent (the `MimeMapManager`
service methods, the map-init event, the JSON feed), read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Sophron – MIME Types settings page](images/settings.png)

## Where it lives in the admin menu

Sophron adds a single configuration page at **Configuration → System → Sophron**
(`/admin/config/system/sophron`), titled **Sophron – MIME Types**. As the screenshot
above shows, the page is organised into vertical tabs:

- **MIME type guessing** — tells you whether Drupal core or Sophron is currently
  providing MIME-type guessing, and links to the `sophron_guesser` submodule.
- **Mapping** — choose which MIME-map class backs the module and apply map commands
  (overrides) that add or adjust type-to-extension mappings.
- **MIME types** — browse the MIME types the active map knows about.
- **File extensions** — browse the file extensions the active map knows about.

Everything is saved with the **Save configuration** button at the bottom of the page.

## Contents

1. [Installation](installation/index.md) — install Sophron and the FileEye/MimeMap
   library with Composer, enable the module, and (optionally) enable the
   `sophron_guesser` submodule.
2. [Configuration](configuration/index.md) — walk through the settings page: choose
   the MIME-map class and apply map commands to add or correct type-to-extension
   mappings.

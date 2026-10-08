<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Uppy Transliterate Filename (uppy_transliterate_filename) — agent index
**Client-side JS that transliterates/sanitizes filenames of files uploaded via the Uppy uploader.**

- **Version:** 1.0.x (1.0.1)
- **Core:** ^10 || ^11
- **Depends on:** uppy (requires `drupal/uppy ^3.0.1` + patch drupal.org/i/3487091)
- **Library:** `uppy_transliterate_filename` (JS in `js/`), applied via `drupalSettings.uppyOverrides`.
- **Rules:** spaces→`-`; drop chars not in `[0-9A-Za-z_.-]`; collapse repeated `_`/`.`/`-`; lowercase.

**Security:** no routes, permissions, or server code — a front-end filename normaliser only. Note it is client-side (JS), so it improves hygiene but is not a server-side validation control; Drupal core still sanitizes filenames on save.

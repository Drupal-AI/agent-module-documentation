<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filefield to Media Copy (filefield_to_mediafield) — agent index

**Copies legacy file/image field values into an existing, empty core Media reference field on the same entities — a post-migration Drush helper.**

- **Version:** 1.0.x
- **Core:** ^8.9 || ^9 || ^10 || ^11
- **Dependencies:** file, media
- **Surface:** Drush only. Command `filefield-to-media:copy` (alias `fftm`); service `filefield_to_mediafield` (class `FileToMedia`). No routes, no permissions, no config.
- **Behavior:** creates Media entities (uid 1, published) wrapping each file; de-duplicates by `sha1_file` hash unless `--no-reuse`.

**Security:** CLI/Drush-only; no routes, permissions, or web-facing endpoints. No security findings.

See [drush/filefield_to_mediafield.md](drush/filefield_to_mediafield.md) for the command reference.

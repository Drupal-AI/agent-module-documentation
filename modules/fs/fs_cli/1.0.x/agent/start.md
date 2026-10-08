<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File System to CLI (fs_cli) — agent index
**Drush-only helper that wraps core's `file_system` service in commands to check, copy, move, scan, create and delete files/directories.**

**Version:** 1.0.x  ·  **Core:** ^10 || ^11
- **Commands (drush.services.yml):** `fs:directory-exists` (fs-de), `fs:file-exists` (fs-fe), `fs:move`, `fs:copy`, `fs:scan-dir`, `fs:mkdir`, `fs:delete-dir`. Output serialised via `@serializer` (default JSON).
- **Routes / permissions / config:** none.
- **Security:** strictly CLI-only — no web route or controller, so no path-traversal / arbitrary-file endpoint. Commands act on any operator-supplied path (incl. destructive `fs:move`/`fs:delete-dir`); access is bounded by server Drush access only.

See [drush/fs_cli.md](drush/fs_cli.md)

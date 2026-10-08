<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Guide Tests (user_guide_tests) — agent index
**Hidden testing module: functional tests that verify the Drupal User Guide steps and generate its screenshots and DB/file backups.**

- **Version:** 11.x (info.yml `version: VERSION`; installed on the `11.x` branch)
- **Core:** ^10 || ^11
- **`hidden: TRUE`** — no runtime features; tests live in `tests/src/FunctionalJavascript` (one class per language).
- **Test deps:** Honey theme, Admin Toolbar, Backup & Migrate.
- **Helper scripts:** `cropimages.sh`, `compareimages.sh`, `copybackups.sh`; backups under `backups/`.

**Security:** developer/CI-only fixture — no routes, permissions, services, or user-facing features. Not for production sites.

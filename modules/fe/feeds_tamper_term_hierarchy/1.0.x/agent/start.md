<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Tamper Term Hierarchy (feeds_tamper_term_hierarchy) — agent index

**Tamper plugin `import_term_hierarchy`: delimited path string → deepest taxonomy term id, resolving/creating each level under its parent.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** taxonomy, tamper
- **Plugin:** `Drupal\feeds_tamper_term_hierarchy\Plugin\Tamper\ImportTermHierarchy` (id `import_term_hierarchy`, category Text).
- **Settings:** `delimiter` (default `>`), `vocabulary` (required), `allow_autocreate` (default TRUE), `match_anywhere` (default FALSE).
- **Behavior:** splits on delimiter → trims/drops empties → per segment `loadByProperties(name,vid[,parent])`; reuse, else create (if autocreate) else `SkipTamperDataException`; returns deepest term id. Per-instance `termIdCache`.
- **Security:** no routes/permissions/endpoints; runs inside Feeds import (privileged). All term ops via entity storage API — no raw SQL. No security findings.

See [configure/import.md](configure/import.md)

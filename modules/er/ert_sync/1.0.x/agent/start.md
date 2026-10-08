<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Translation Sync (ert_sync) — agent index

**On node update, copies changed entity-reference field values from the source to the node's other translations (batch save). Hook-only, no config/routes.**

- **Version:** 1.0.x  •  core: `^9 || ^10`  •  package: Custom.
- **Logic:** `ert_sync_entity_update()` → iterates bundle field defs, finds `entity_reference` fields, calls `synchronize_trans()` which compares source vs each translation and sets values when target empty / `$only_empty === FALSE` / cardinality differs, then `batch_set` saving translations. `dont_update_translate` flag prevents recursion.
- **No routes/permissions/config.**

**Security (reviewed, sound):** runs only in the server-side node-update hook; no HTTP endpoint. Governed by normal node save access. Note: the update-hook guard (`if (!isset($entity->dont_update_translate)) return;`) makes actual sync behaviour conditional — a correctness/reliability quirk, not a security issue.

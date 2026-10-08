<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Backlinks (backlinks_index) — agent index

**Maintains a reverse index of internal node-to-node links and shows a node's inbound backlinks on a tab.**

- **Version:** 1.1.x
- **Core:** ^9 || ^10 || ^11
- **Dependencies:** `hook_post_action`, `redirect`
- **Routes:**
  - `backlinks_index.settings` → `/admin/config/content/backlinks` — **`administer backlinks_index`** (bundle selection, Reindex, Purge).
  - `entity.node.backlinks` → `/node/{node}/backlinks` — **`access backlinks_index`** (backlinks tab; `_admin_route`).
- **Permissions:** `administer backlinks_index`, `access backlinks_index`.
- **Service:** `backlinks_index.manager` (`BacklinksManager`) — scan/index/list; `backlinks_index.drush_commands`.
- **Drush:** `backlinks_index:reindex` (`b_i:reindex`), `backlinks_index:purge` (`b_i:purge`).
- **Storage:** custom `backlinks` table + `backlinks` base field on nodes. Indexing runs on `hook_node_postsave` and via Batch (`BacklinksScanBatch`).

**Security:** both routes permission-gated (no anonymous access); all DB access via parameterized query builder (`select`/`insert`/`update`/`delete`/`truncate` with bound conditions); link extraction is read-only regex over rendered internal content. No mutating public endpoint, no raw SQL, no disabled TLS. See [configure/backlinks.md](configure/backlinks.md).

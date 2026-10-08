<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prev/Next (prev_next) — agent index

Precomputed **previous/next node** navigation. Neighbour ids are stored in a lookup table and
maintained by entity hooks, so each page reads one indexed row instead of running a whole-table
ordered query. Version dir **8.x-2.x** (installed `8.x-2.0-beta1`, beta). Core
`^8 || ^9 || ^10 || ^11`. Depends on **block** (core).

## What it provides
- **Schema** (`prev_next.install`): table `prev_next_node` — `nid` (PK), `prev_nid`, `next_nid`,
  `changed`; indexes on `prev_nid` and `next_nid`.
- **Services** (`prev_next.services.yml`):
  - `prev_next.helper` → `Drupal\prev_next\PrevNextHelper` (read API + config helpers).
  - `prev_next.api` → `Drupal\prev_next\PrevNextApi` (write API: build/update/remove index rows).
- **Block plugin** `prev_next_block` (`src/Plugin/Block/PrevNextBlock.php`) — context: `entity:node`;
  theme hook `prev_next_block` (template `templates/prev-next-block.html.twig`).
- **Config form** `PrevNextConfigForm` at route `prev_next.config_form`
  (`/admin/config/system/prev-next`), permission `administer prev next`.
- **Hooks** (`prev_next.module`): `hook_entity_insert/update/delete` maintain the index;
  `hook_theme`, `hook_help`.
- **Config**: `prev_next.settings` (`batch_size`, default 200) + per-type `prev_next.node_type.*`
  objects; schema in `config/schema/prev_next.schema.yml`.

## Read the neighbour ids (service API)
`\Drupal::service('prev_next.helper')` → `getPrevId($nid)`, `getNextId($nid)`,
`getPrevnextId($nid, 'prev'|'next')`. Each is a single `SELECT … FROM {prev_next_node} WHERE nid = :nid`.
(The `prev_next_nid()` function in the project's drupal.org text is the legacy 7.x API and does not
exist in this branch.)

## Solution docs
- [Config & indexing](config/settings.md) — settings, per-type options, re-index, cron batch.
- [Block & read API](blocks/prev-next-block.md) — placing the block, template vars, service reads.
- [Index maintenance internals](api/indexing.md) — how `PrevNextApi` builds/repairs rows.

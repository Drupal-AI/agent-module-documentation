<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot — Drush commands

Provided by `src/Drush/Commands/MenuAutopilotCommands.php` (attribute-based, injects `menu_autopilot.sync_manager`). Both are idempotent and safe to run repeatedly; they act only on the managed menus (`menu_autopilot.settings` → `managed_menus`).

## `menu-autopilot:rebuild` (alias `ma:rebuild`)

Reconcile every dynamic parent: create, reorder, rename, and prune managed child links from published content (calls `NavSyncManager::reconcile()`). Use after a bulk import, after changing a parent's source, or on a schedule as a self-healing pass. A second run in a row makes no changes.

After reconciling it reports automatic children that are still disabled (`NavSyncManager::disabledManagedChildren()`) — a published node whose link no menu shows. Each is logged with the parent, node, link id, and the reason: either "another module disabled it while Menu Autopilot was saving it, and this run could not enable it" (run the rebuild as an account that may enable menu links) or "it was disabled outside Menu Autopilot" (an editor must enable it).

```
drush menu-autopilot:rebuild
drush ma:rebuild
```

## `menu-autopilot:normalize-uris` (alias `ma:fix-uris`)

Scan the managed menus and rewrite any link that targets an editorial or internal node route (e.g. `/node/12/latest`, `internal:/node/12`, `base:node/12`) to a canonical `entity:node/<nid>` URI, so it resolves to the node's real path alias instead of 404-ing a decoupled front end (calls `NavSyncManager::normalizeNodeUris()`). Touches any matching link, managed or not, so it doubles as a one-time cleanup when adopting the module. A one-time cleanup when adopting the module; already-canonical links are untouched.

```
drush menu-autopilot:normalize-uris
drush ma:fix-uris
```

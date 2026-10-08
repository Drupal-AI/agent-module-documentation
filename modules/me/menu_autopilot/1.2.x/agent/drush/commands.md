<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot — Drush commands

Provided by `src/Drush/Commands/MenuAutopilotCommands.php` (attribute-based). Both are idempotent and safe to run repeatedly; they act only on the managed menus (`menu_autopilot.settings` → `managed_menus`).

## `menu-autopilot:rebuild` (alias `ma:rebuild`)

Reconcile every dynamic parent: create, reorder, rename, and prune managed child links from published content. Use after a bulk import, after changing a parent's source, or on a schedule as a self-healing pass. A second run in a row makes no changes.

```
drush menu-autopilot:rebuild
drush ma:rebuild
```

## `menu-autopilot:normalize-uris` (alias `ma:fix-uris`)

Scan the managed menus and rewrite any link that targets an editorial or internal node route (e.g. `/node/12/latest`, `internal:/node/12`) to a canonical `entity:node/<nid>` URI, so it resolves to the node's real path alias instead of 404-ing a decoupled front end. A one-time cleanup when adopting the module; already-canonical links are untouched.

```
drush menu-autopilot:normalize-uris
drush ma:fix-uris
```

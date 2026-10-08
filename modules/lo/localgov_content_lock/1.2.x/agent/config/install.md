<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# localgov_content_lock — install behaviour & configuration

This module owns almost no runtime behaviour; it sets a default on install and adds two admin links.
Everything operational is Content Lock's.

## Install / enable
`ddev drush en localgov_content_lock -y` (pulls in `content_lock`). Composer requires
`drupal/content_lock:^3.0`.

`localgov_content_lock_install($is_syncing)` in `localgov_content_lock.install`:
- Returns immediately if `$is_syncing` (config import) — so a config-sync install does not clobber
  the incoming `content_lock.settings`.
- Otherwise gets the editable `content_lock.settings` config and sets
  `types.node = ['*' => '*']`, then saves. This enables pessimistic locking on **all** node
  bundles via Content Lock's wildcard form (key = bundle or `*`, value = `*`).

The write is one-shot: it runs only at install time. Later changes are made in Content Lock's config,
not here, and re-installing (outside config sync) resets `types.node` back to the wildcard.

## Config it touches
- Config object: `content_lock.settings` (owned by the Content Lock module, not this one).
- Key set: `types.node` → `{'*': '*'}`.
- This module ships **no** `config/install/*` and **no** `config/schema/*` — it edits Content Lock's
  config imperatively. So `provides_config_schema` is false.

## Admin links (both target `view.locked_content.page_1`)
- `localgov_content_lock.links.task.yml`: a local task "Locked" under `system.admin_content`
  (weight 100) — the tab on `/admin/content`.
- `localgov_content_lock.links.menu.yml`: an admin menu item "Locked content" under
  `system.admin_content`.
- The route `view.locked_content.page_1` and the `/admin/content/locked-content` path are provided by
  Content Lock, not this module.

## Operating it (all in Content Lock)
- Settings + timeout: `/admin/config/content/content_lock`. Lock timeout default is 30 minutes.
- Breaking / releasing locks and who may do so: governed by Content Lock's permissions (e.g.
  "Break content lock"). Assign to a role that is reachable quickly, not administrator-only, or stale
  locks block editors. Content Lock records who broke a lock.
- Per-translation locking and other toggles are Content Lock settings, unaffected by this module
  beyond the initial `types.node` default.

## Verifying
Per `tests/src/Functional/ContentLockTest.php`: open a node's `/node/{nid}/edit` and you should see
"This content is now locked against simultaneous editing."; the node then appears in the list at
`/admin/content/locked-content`.

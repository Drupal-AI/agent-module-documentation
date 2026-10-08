<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions by Entity — agent index

Submodule of **Permissions by Term** (`dependencies: permissions_by_term`). It applies the same
user/role→term grants to **non-node fieldable entities** (media, paragraphs, block content,
custom entities). **No config, no permissions, no schema, no routes, no Drush, no plugins of its
own** — `configure: null`.

- **What must be configured (on the parent module) before it does anything, and the gotchas**
  → [configure/setup.md](configure/setup.md)
- **`AccessChecker`, the enforcement points, caching and the event** →
  [api/access-checker.md](api/access-checker.md)

Key facts:

- Services: `permissions_by_entity.access_checker`, `permissions_by_entity.checked_entity_cache`,
  `permissions_by_entity.access_result_cache`, plus two event subscribers.
- `AccessChecker extends \Drupal\permissions_by_term\Service\AccessCheck` and implements
  `AccessCheckerInterface` with `isAccessControlled()` and `isAccessAllowed()`.
- **Nodes are excluded on purpose** — `isAccessControlled()` returns `FALSE` for `node`, leaving
  them to the parent module.
- **Hard prerequisite:** `permissions_by_term.settings:target_bundles` must be **non-empty** and
  intersect the taxonomy field's `handler_settings.target_bundles`, otherwise nothing is ever
  controlled.
- Grants are still the parent module's `permissions_by_term_user` / `permissions_by_term_role`
  tables — see [the parent docs](../../../../3.1.x/agent/start.md).

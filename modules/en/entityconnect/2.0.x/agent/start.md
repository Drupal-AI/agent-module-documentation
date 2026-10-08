<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Connect — agent index

Adds "add new content" (+) and "edit current content" (pencil) buttons to Entity Reference widgets.
Pressing one caches the parent form in **private tempstore** and redirects to the target entity type's
real core add/edit form; a return route restores the parent form with the new/edited entity selected.
Depends on core `field`. Config UI: `entityconnect.administration_form`. Provides permissions + config
schema; no plugins, no Drush.

- **Global default settings + per-field third-party overrides (button/icon visibility)** →
  [configure/settings.md](configure/settings.md)
- **The three permissions, the custom access check, and why the flow does NOT bypass core create/edit
  access** → [permissions/permissions.md](permissions/permissions.md)
- **The alter hooks in `entityconnect.api.php` (exclude forms, target fields, child/return form alters)**
  → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Routes: `entityconnect.add` / `.edit` (perm `entityconnect add button` / `edit button`),
  `entityconnect.return` (custom access = add OR edit perm), `entityconnect.administration_form`
  (perm `administer entityconnect`).
- The add/edit controllers redirect to core routes (`node.add`, `user.admin_create`,
  `entity.<type>.add_form` / `.edit_form`) — **core enforces the actual create/edit access there.**
- Parent form state is cached in `PrivateTempStore('entityconnect')`, keyed by a random `cache_id`
  (per-user/session isolation).
- Custom render element `entityconnect_submit` (`src/Element/EntityconnectSubmit.php`) is the button.

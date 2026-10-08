<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User View Mode (user_view_mode) — agent index

Assigns an existing **user view mode to each role**, then swaps a user profile into that view mode
when the account renders. Version **8.x-1.4**. Core `^10 || ^11`. No dependencies, no permissions,
no routes, no services. The entire module is **two hooks** in `user_view_mode.module`.

## Mechanism (read this first)
1. **`hook_form_user_role_form_alter()`** — adds two fields to the role add/edit form
   (`admin/people/roles/manage/{role}`): a **View Mode** `select` (options are the user entity's
   view modes) and a **Weight** number field. A submit handler saves both as **third-party
   settings** on the `user.role.*` config entity: `user_view_mode.view_mode` and
   `user_view_mode.weight`. The module ships **no config schema** for these keys.
2. **`hook_entity_view_mode_alter()`** — when a `user` entity renders in `full` or `default`, it
   reads the account's non-locked roles (`getRoles(TRUE)` — anonymous/authenticated excluded) and
   rewrites `$view_mode` to the configured value. **One** role → that role's setting. **Several**
   roles → the role with the **highest weight** wins. Falls back to `full` when a role has no
   setting. Does nothing if the account has no non-locked role.

## Two accuracy notes
- **The tie-break uses the role's core weight** (`Role::getWeight()`, the drag order at
  `admin/people/roles`), **not** the "Weight" field this module adds to the form. That field is
  written and shown as a form default but is **never read** by the selection logic — effectively
  dead for multi-role resolution.
- **A view mode is a display decision, not access control.** Choosing a role's view mode changes
  which fields appear in that render only. Drupal still enforces user-view access and per-field
  access; every field stays readable through **JSON:API**, **Views**, a **search index**, or a
  different view mode. For anything confidential use **field-level access** — this is the wrong
  tool.

## Configure
- `agent/config/view-mode-per-role.md` — set a role's view mode and understand multi-role resolution.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: a view mode per role

There is **no dedicated settings page**. Configuration lives on the standard role form.

## Steps
1. (Optional) Create the user view modes you want at
   `admin/structure/display-modes/view` (they must be enabled for the *User* entity under the
   "Custom display settings" of `admin/config/people/accounts` → Manage display), and lay out their
   fields in the User display settings.
2. Go to **People → Roles** and edit (or add) a role: `admin/people/roles/manage/{role}`.
3. Set **View Mode** — the select lists every user view mode. This is the display the module will
   switch a profile into for accounts holding this role.
4. **Weight** field: present but **inert for selection** — see below. You can leave it at 0.
5. Save the role. The values are stored as third-party settings
   (`user_view_mode.view_mode`, `user_view_mode.weight`) on the `user.role.{id}` config entity.

## When the swap happens
`hook_entity_view_mode_alter()` only acts when a **user** entity is being rendered in the **`full`**
or **`default`** view mode (e.g. the canonical `/user/{uid}` page). Other view modes, and other
entity types, are left untouched.

## Multi-role resolution (important)
- **One** non-locked role → its configured view mode is used.
- **Several** non-locked roles → the role with the **highest weight** is chosen, where weight means
  the **role entity's core weight** (the drag order at `admin/people/roles`) — **not** the "Weight"
  field this module adds. That form field is saved but never consulted here.
- Locked roles (**anonymous**, **authenticated**) are excluded via `getRoles(TRUE)`. An account with
  no non-locked role gets no change (stays on `full`/`default`).
- A role with no configured view mode falls back to `full`.

To make a role "win" for multi-role users, raise its position (weight) on the roles listing page.

## Export / staging
Because the settings ride on the `user.role.*` config entities, they export with normal
configuration (`drush config:export`) and deploy like any other role config. Note there is **no
config schema** shipped for the `user_view_mode.*` keys; this does not block export but means the
values are untyped in schema-aware tooling.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User List Permission (user_list_permission) — agent index

Adds one permission, **`access people list`**, so a role can view `/admin/people` (the People
list) **without** `administer users`. Depends only on core `user`. Installed version **2.2.0**.
Core requirement **`>=11.1`** (Drupal 11.1+, no upper bound) and declared **`php: 8.3`** — both
tighter than most contrib; verify before planning around it. No config UI, no config schema, no
Drush commands, no plugins.

## The problem it solves
Core gates `/admin/people` on **`administer users`**, and that permission also grants editing any
account, changing emails and passwords, blocking, cancelling, and assigning roles. There is no
read-only middle setting, so anyone who needs to merely *see* the user list must be trusted to take
over any account. The common workaround — a custom People view with its own access — duplicates the
list and drifts from core. This module supplies the missing least-privilege permission instead.

## Mechanism (read this before reasoning about behavior)
- **Permission:** `user_list_permission.permissions.yml` defines `access people list`, marked
  `restrict access: true` (correct — the list discloses account data).
- **On install** (`user_list_permission.install`, `hook_install`):
  1. If `views.view.user_admin_people` still uses the core default access (`type: perm`,
     `perm: administer users`), its access perm is rewritten to `access people list`. A customised
     view is left untouched.
  2. Every existing role that holds `administer users` is granted `access people list`, so current
     admins keep working with no manual step.
- **In a standard (Views-enabled) install**, `/admin/people` is served by the `user_admin_people`
  Views display. Views replaces the `entity.user.collection` route with the view's route, copying
  the view's access onto it — so the effective re-gating to `access people list` comes from the
  rewritten **view access**, verified live: both `entity.user.collection` and
  `view.user_admin_people.page_1` require `access people list`.
- **Route subscriber** (`src/Routing/UserListPermissionRouteSubscriber.php`) is intended to re-gate
  the non-Views core `entity.user.collection` route, but its guard only fires when the requirement
  equals `administer account settings`. Current core uses `administer users`, so this check does
  **not** match and the subscriber is effectively a no-op on core 11.1+. This matters only on a
  Views-disabled site: there the permission would not re-gate `/admin/people` (it stays on
  `administer users`) — a fail-closed functionality gap, not an opening. See `agent/permissions/`.

## What the list exposes / does NOT let a viewer do
- Granting `access people list` discloses the People list: usernames, status, roles, member-for,
  last-access — plus **email** if the site's copy of the view adds a mail column.
- Operations links (edit/cancel) and the **bulk-action form** on the list remain independently
  access-checked by core. A role with only `access people list` can see the list but **cannot**
  edit, block, cancel, or role-change accounts through it — those still require `administer users`.

## Files
- `user_list_permission.info.yml` — core `>=11.1`, `php: 8.3`, deps: `drupal:user`.
- `user_list_permission.permissions.yml` — the `access people list` permission.
- `user_list_permission.install` — view-access rewrite + role grants on install.
- `user_list_permission.services.yml` — registers the route subscriber (autowired).
- `src/Routing/UserListPermissionRouteSubscriber.php` — route re-gate (see note above).

## Deeper docs
- `agent/permissions/` — the permission, exact install-time behavior, and the route-subscriber caveat.

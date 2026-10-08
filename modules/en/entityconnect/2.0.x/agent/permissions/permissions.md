<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Connect permissions & access model

Source: `entityconnect.permissions.yml`, `entityconnect.routing.yml`,
`src/Access/CustomAccessCheck.php`, `src/Controller/EntityconnectController.php`.

## Permissions

| Permission | Gates |
|---|---|
| `administer entityconnect` | The global settings form `admin/config/content/entityconnect`. |
| `entityconnect add button` | Reachability of the `entityconnect.add/{cache_id}` route (and the "+" button). |
| `entityconnect edit button` | Reachability of the `entityconnect.edit/{cache_id}` route (and the pencil button). |

None are marked `restrict access: true`. `entityconnect.return` uses the custom access check
`_entityconnect_access_check`, which allows the user if they hold `entityconnect add button` **OR**
`entityconnect edit button`.

## Why these permissions do NOT grant entity create/edit

This is the key point when reasoning about privilege: the add/edit routes are **intermediaries**, not
the thing that creates data.

- `EntityconnectController::add()` / `::edit()` look up the cached target entity type, then call
  `getAddRoute()` / build the core edit URL and issue a `RedirectResponse` to the **standard core form**
  — `node.add`, `user.admin_create`, `shortcut.link_add`, or `entity.<type>.add_form` / `.edit_form`.
- Core then renders that form under **its own** access control. A user with `entityconnect add button`
  but without, say, `create article content` is redirected to `node/add/article` and is denied by core
  exactly as if they had navigated there directly. Entity Connect adds no create/edit capability of its
  own; it only decides whether the *button/detour* is offered.

So holding the add/edit-button permission is safe to grant to editors — it cannot be used to create or
edit entities the user could not already create or edit through the normal UI.

## Cache isolation

The detour stashes the in-progress parent form via `EntityconnectCache`, which wraps
`PrivateTempStore('entityconnect')` keyed by a random `cache_id`. Private tempstore is per-user (per
session for anonymous), so one user cannot read or resume another user's cached form via a guessed
`cache_id`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# marketo_ma_user

Integrates Marketo with core user actions. Deps: `marketo_ma`, `drupal:user`.

## Capture (src/Service/MarketoMaUserService.php, service `marketo_ma.user`)
Module hooks (`marketo_ma_user.module`) call the service on:
- `hook_user_login` → `userLogin()` (if `login` in configured `events`; syncs with `_mkto_trk` cookie).
- `hook_ENTITY_TYPE_create` (user) → `userCreate()` (if `create` in events).
- `hook_ENTITY_TYPE_update` (user) → `userUpdate()` (if `update` in events).

`updateLead(UserInterface, $sync_cookie)` builds a `Lead` from the configured field `mapping`
(user field → Marketo field id, intersected with the site's enabled Marketo fields), attaches the
`_mkto_trk` cookie when the update is by the user themself, and hands off to `marketo_ma`’s
`updateLead()`. Requires the REST tracking method to actually reach Marketo. Activity types are cached
in State (`marketo_ma_user.activity_types`).

## Config
Config object `marketo_ma_user.settings` (`events`, `mapping`, `enabled_activities`). Forms:
`Form\Settings` (`.../users`), `Form\FieldMapping` (`.../users/fields`), `Form\UserActivities`
(`.../users/activities`) — all under permission `administer marketo`.

## Per-user data views (src/Controller/MarketoMaUserLeadDataController.php)
Routes require permission **`access all marketo lead data`**:
- `/user/{user}/marketo/lead` → `viewLead()` — table of the Marketo lead record (looked up by the user's
  email via `getLeadByEmail`).
- `/user/{user}/marketo/activity` → `viewActivity()` — recent Marketo activity for that lead.

Permissions declared: `access all marketo lead data` and `access own marketo lead data` — note the second
is defined but **not referenced by any route** (the view routes both use "all"); it is effectively dead.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Restrictions (user_restrictions) — agent index

Admin-defined rules that refuse (or explicitly allow) **account registration, login, and profile
edit** by **username**, **email address**, or **client IP**. The Drupal 8+ replacement for the
"access rules" feature removed from Drupal 7 core. Documented from installed release **2.1.1**
(doc branch `2.1.x`). Core: `^10.6 || ^11`; PHP `8.3`. License GPL-2.0-or-later. No runtime
dependencies, no submodules, no Drush commands.

## What it is / how it works
- Each rule is a `user_restrictions` **config entity** (`config_prefix: user_restrictions`),
  managed at `/admin/config/people/user-restrictions`.
- Rule fields (`config_export` in `src/Entity/UserRestrictions.php`): `plugin` (restriction type),
  `pattern` (a **raw PCRE regex**, max 64 chars), `pattern_type` (`1` = allow / `0` = reject —
  `UserRestrictionInterface::PATTERN_ALLOW = 1`), `forms` (subset of `user_register_form`,
  `user_login_form`, `user_form`; empty = all forms), `no_expiration` + `expiration` (timestamp),
  `weight`, `status`, `id`, `label`.
- Enforcement runs as **form validation** on the three user forms:
  `Hook/UserRestrictionsFormHooks::userFormAlter()`
  (`#[Hook('form_alter', order: Order::Last)]`) attaches validate handlers to the register, login,
  and edit forms. `UserRestrictionsManager::matchesRestrictions()` loads enabled, non-expired rules by
  weight and each rule runs `preg_match('/' . $pattern . '/i', $data)`.
  - `src/Entity/UserRestrictions.php::matches()` — the actual match (un-anchored, case-insensitive);
    if a rule's `forms` list is non-empty and does not contain the current form, it is skipped.
  - `src/Hook/UserRestrictionsFormHooks.php` — the three validators + bypass logic.
  - `src/UserRestrictionsManager.php` — rule entity query, match loop, error/log (`@internal`).
- First match wins: an **allow** match permits and short-circuits; a **reject** match logs a
  notice and sets a form error. Accounts (or the admin acting) with **`bypass user restrictions`**
  are skipped.
- On login, restrictions are checked **only after authentication succeeds**
  (`form_state->get('uid')` must be set) — an IP/name rule on the login form blocks valid
  credential holders, not failed attempts.
- Cron (`Hook/UserRestrictionsCronHooks::cron()` → `UserRestrictionsManager::deleteExpiredRules()`)
  deletes expired rules. Legacy procedural `hook_cron`/`hook_help`/`hook_form_alter` in
  `user_restrictions.module` are `#[LegacyHook]` shims that delegate to the OOP hook services.

## Restriction type plugins (`UserRestrictionType`)
Plugin namespace `Plugin/UserRestrictionType`, attribute
`Drupal\user_restrictions\Attribute\UserRestrictionType` (legacy `Annotation/UserRestrictionType`
also exists), manager service `plugin.manager.user_restriction_type`, alter hook
`user_restriction_type_info`. See [agent/plugins/restriction-types.md](plugins/restriction-types.md).
Built-in IDs:
- `name` — **Username** (`src/Plugin/UserRestrictionType/Name.php`), matches the `name` form value.
  NOTE the registered ID is `name`, but the entity default `$plugin` and the
  `change_plugin_id` post-update reference `user_restrictions_username` — an inconsistency (see
  plugins doc).
- `user_restrictions_email` — **Email**, matches the `mail` form value.
- `user_restrictions_client_ip` — **Client IP**, matches `Request::getClientIp()`
  (trusted-proxy-safe, not raw `X-Forwarded-For`).

## Permissions (both `restrict access: true`)
- `administer user restrictions` — manage rules; also the entity `admin_permission`; gates all routes.
- `bypass user restrictions` — exempt from all rule checks. (Renamed from the old
  `bypass user restrictions rules` by `user_restrictions_post_update_permissions`.)

## Routes (`user_restrictions.routing.yml`)
`entity.user_restrictions.collection` (list/configure), `user_restrictions.add`,
`entity.user_restrictions.edit_form`, `.delete_form`, `.enable`/`.disable`
(`UserRestrictionsController::performOperation`, `_csrf_token: 'TRUE'`). All require
`administer user restrictions`.

## Config / patterns
- The **pattern is a regular expression**, applied as `/pattern/i`, un-anchored, ≤ 64 chars. The
  old README's `%` / `.` wildcard syntax is stale — write regex; escape metacharacters to match
  literally. The edit form (`src/Form/UserRestrictionsEditForm.php`) links regex101 and warns
  about ReDoS, and rejects a duplicate plugin+pattern rule.
- Config schema: `config/schema/user_restrictions.schema.yml`. Many legacy keys (`name`,
  `rule_type`, `access_type`, `expiry`) are deprecated aliases (removed in 3.0.0); current keys
  are `id`, `plugin`, `pattern_type`, `expiration`, `no_expiration`, `weight`. The entity exposes
  the removed names via `__get`/`__set` magic with `@trigger_error` deprecations.

## Gotchas
- **Scope is the register, login, and profile-edit forms** — rules are evaluated as those forms
  are submitted, so target them at the form-driven account flows.
- Anchor allow patterns to avoid over-matching (e.g. an un-anchored `gmail\.com` also matches
  `gmail.com.example.net`).
- No submodules, no Drush commands, no service/library dependencies.

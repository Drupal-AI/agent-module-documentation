<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Restrictions (user_restrictions) — agent index

Admin-defined rules that refuse (or explicitly allow) **account registration, login, and profile
edit** by **username**, **email address**, or **client IP**. The Drupal 8+ replacement for the
"access rules" feature removed from Drupal 7 core. Documented from installed release **2.1.1**
(doc branch `2.0.x`). Core: `^10.6 || ^11`; PHP `8.3`. License GPL-2.0-or-later.

## What it is / how it works
- Each rule is a `user_restrictions` **config entity** (`config_prefix: user_restrictions`),
  managed at `/admin/config/people/user-restrictions`.
- Rule fields: `plugin` (restriction type), `pattern` (a **raw PCRE regex**), `pattern_type`
  (`1` = allow / `0` = reject — `UserRestrictionInterface::PATTERN_ALLOW = 1`), `forms`
  (subset of `user_register_form`, `user_login_form`, `user_form`; empty = all forms),
  `no_expiration` + `expiration` (timestamp), `weight`, `status`.
- Enforcement is **form-validation only**: `UserRestrictionsFormHooks::userFormAlter()`
  (`#[Hook('form_alter', order: Order::Last)]`) attaches validate handlers to the three user
  forms. `UserRestrictionsManager::matchesRestrictions()` loads enabled, non-expired rules by
  weight and runs `preg_match('/' . $pattern . '/i', $data)`.
  - `src/Entity/UserRestrictions.php::matches()` — the actual match (un-anchored, case-insensitive).
  - `src/Hook/UserRestrictionsFormHooks.php` — the three validators + bypass logic.
  - `src/UserRestrictionsManager.php` — rule query, match loop, error/log.
- First match wins: an **allow** match permits and short-circuits; a **reject** match logs a
  notice and sets a form error. Accounts (or the admin acting) with **`bypass user restrictions`**
  are skipped.
- On login, restrictions are checked **only after authentication succeeds** (`form_state->get('uid')`
  must be set) — an IP/name rule on the login form blocks valid credential holders, not failed attempts.
- Cron (`UserRestrictionsCronHooks::cron()` → `deleteExpiredRules()`) deletes expired rules.

## Restriction type plugins (`UserRestrictionType`)
Plugin namespace `Plugin/UserRestrictionType`, attribute
`Drupal\user_restrictions\Attribute\UserRestrictionType`, manager service
`plugin.manager.user_restriction_type`, alter hook `user_restriction_type_info`. See
[agent/plugins/restriction-types.md](plugins/restriction-types.md). Built-in IDs:
- `name` — **Username** (`src/Plugin/UserRestrictionType/Name.php`), matches `name` form value.
  NOTE the ID is `name`, but the entity default and the `change_plugin_id` post-update reference
  `user_restrictions_username` — an inconsistency in 2.1.1 (see plugins doc).
- `user_restrictions_email` — **Email**, matches `mail` form value.
- `user_restrictions_client_ip` — **Client IP**, matches `Request::getClientIp()`
  (trusted-proxy-safe, not raw `X-Forwarded-For`).

## Permissions (both `restrict access: true`)
- `administer user restrictions` — manage rules; also the entity `admin_permission`; gates all routes.
- `bypass user restrictions` — exempt from all rule checks. (Renamed from the old
  `bypass user restrictions rules` by `user_restrictions_post_update_permissions`.)

## Routes
`entity.user_restrictions.collection` (list/configure), `.add`, `.edit_form`, `.delete_form`,
`.enable`/`.disable` (CSRF-token protected controller ops). All require
`administer user restrictions`.

## Config / patterns
- The **pattern is a regular expression**, applied as `/pattern/i`, un-anchored. The old README's
  `%` / `.` wildcard syntax is stale — write regex; escape metacharacters to match literally.
- Config schema: `config/schema/user_restrictions.schema.yml`. Many legacy keys (`name`,
  `rule_type`, `access_type`, `expiry`) are deprecated aliases (removed in 3.0.0); current keys
  are `id`, `plugin`, `pattern_type`, `expiration`.

## Gotchas
- **Not enforced outside the three forms** — programmatic `User::create()`, Drush, REST/JSON:API
  user creation bypass all restrictions. It is a form-level anti-abuse tool, not a hard gate.
- Un-anchored allow patterns can over-match (e.g. `gmail\.com` also allows `gmail.com.evil.net`).
- No submodules, no Drush commands, no service/library dependencies.

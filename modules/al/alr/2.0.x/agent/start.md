<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# After Login/Logout Redirection (alr) — agent index

Config-only module that sets a per-role `destination` after login and after logout. No entities, services, permissions, plugins, or Drush commands. Core-only (`^8 || ^9 || ^10 || ^11`), package `Development`.

## What it provides
- One route/form: `alr.admin_settings_form` → `/admin/config/alr-configuration`, class `Drupal\alr\Form\ALRConfigurationForm` (extends `ConfigFormBase`), gated by core permission `administer site configuration`.
- Menu link: `alr.admin_settings_form` under `system.admin_config_system` (`alr.links.menu.yml`).
- Config object: `alr.settings` with `login` and `logout` maps keyed by role id → `{ redirect_url, weight }`. No config schema shipped.
- Runtime hooks in `alr.module`: `hook_form_alter()` adds a submit handler to `user_login_form`; `hook_user_logout()`; helper `alr_get_config($key)`; `hook_help()`.

## Behavior
- Login submit handler `alr__login_page_redirect_user_login_form_submit()` and `alr_user_logout()` take the current user's roles, `sort()` them, use `$roles[0]` (alphabetically first), read that role's `redirect_url`, and set the request `destination` — only if no `destination` is already present.

## Gotchas
- `alr.info.yml` declares `configure: alr.info.admin_settings_form`, which does NOT match the real route id `alr.admin_settings_form` (broken config link); reach the form via the menu link or the path.
- `provides_config_schema` is false (no `config/schema`). `PathValidatorInterface` is injected but never used — stored `redirect_url` values are not path-validated.
- Only the first sorted role's rule applies; multi-role users do not get per-role merging.

## Solution docs
- [Configuration & settings form](config/settings.md)
- [Runtime redirect behavior (hooks)](api/redirect-behavior.md)

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Subresource Integrity UI (sri_ui) — agent index

Lets a site add **`integrity`**, **`crossorigin`**, **`async`** and a cache-busting **query string** to
**external** JS/CSS assets, so the browser verifies a CDN-hosted file against a pinned SHA-256 hash
before executing it. Configuration lives at **`/admin/config/services/sri`** (route
`sri_ui_config.admin_config_sri`, gated by `administer site configuration`), where an admin enables the
feature (`status`) and registers one entry per external asset URL with its hash and options. Nothing
is applied until `status` is on **and** the exact asset URL is listed — it does not blanket-harden all
external assets.

Application is done by two hooks in `sri_ui.module`: `hook_library_info_alter()` decorates
`type: external` js/css entries of any declared library whose entry key matches a configured `asset`,
and `hook_page_attachments_alter()` decorates external `<script src>` tags in `html_head`/`html_footer`
whose `src` matches. Hashes can also be **generated/refreshed from the source file**: the
`sri_ui.hashgeneration` service downloads each configured URL (`file_get_contents`), computes
`sha256-<base64>`, and rewrites the stored `integrity` when it changed. That refresh runs from **cron**
(`hook_cron` → `check_all`), from a **Drush** command (`check_all`), and — per asset, throttled by a
timeout — from a **KernelEvents::REQUEST** subscriber on every page load (`check_one_by_one`).

- Depends on: nothing (no `dependencies:` in info.yml). Core: `^8 || ^9 || ^10 || ^11`. Package: `Subresource Integrity UI`.
- Settings page / configure route: **yes** — `sri_ui_config.admin_config_sri` (`/admin/config/services/sri`).
- Permissions: **none of its own**; the form uses core `administer site configuration`.
- Drush: **yes** — `sri-ui:update-assets-hash256` (alias `update-assets-hash256`).
- Plugin types: none. Config schema: **none shipped** (`config/install` only, no `config/schema/`). No fields, no theme templates, no JS/CSS assets of its own.

## What you'd do → where

- **Enable SRI, add an asset URL + hash + crossorigin, tune auto-refresh** → [configure/settings.md](configure/settings.md)
- **Understand the config keys, how the two hooks apply attributes, and why an entry may not take effect** → [configure/settings.md](configure/settings.md)
- **Regenerate hashes from source (service / cron / Drush / request subscriber), or call it from code** → [api/services.md](api/services.md)

## Key facts (real machine names)

- Route: `sri_ui_config.admin_config_sri` → `/admin/config/services/sri`, form `Drupal\sri_ui\Form\AdminSettingsForm` (`sri_ui_settings_form`), requirement `_permission: administer site configuration`. Menu link `sri_ui.miscellaneous` (parent `system.admin_config_services`).
- Services: `sri_ui.hashgeneration` (`Drupal\sri_ui\Services\HashGeneration`; args `@config.factory`, `@logger.factory`, `@cache_tags.invalidator`); `sri_ui.subscriber` (`Drupal\sri_ui\EventSubscriber\SriEventSubscriberCron`, tag `event_subscriber`, listens `KernelEvents::REQUEST` → `onPageLoad`).
- Drush: `sri-ui:update-assets-hash256` / alias `update-assets-hash256` (`Drupal\sri_ui\Commands\SriUiDrushCommands::updateAssetsHash`), registered via `drush.services.yml`. README's `drush update-assets-has256` is a typo; the real alias is `update-assets-hash256`.
- Hooks (`sri_ui.module`): `hook_library_info_alter`, `hook_page_attachments_alter`, `hook_cron`. Helper functions `sri_ui_get_integrity($asset)` and `sri_ui_integrity_status()`.
- Config object `sri_ui.settings` keys: `status` (0/1, default **0** = off), `key_refresh_timout` (string, seconds; default `'3600'`), `last_refresh_timout` (unix timestamp), `assets` (list of `{asset, integrity, crossorigin, query_string, is_check_update, add_async}`).
- Cache tag `sri_ui:library_attachments_cache_tag` is attached in `hook_page_attachments_alter`. (The service's cache clear invalidates the un-prefixed `library_attachments_cache_tag`, so a hash change may need a manual cache rebuild to show — see api/services.md.)
- Hash format produced: `sha256-<base64(raw sha256 of the fetched file body)>`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Tester (api_tester) — agent index

Postman-style REST client embedded in the Drupal admin UI. Version **1.0.0**, core `^10 || ^11`, package Development. Depends only on core `user` + `system` (no Composer requirements; Guzzle from core). No config entities, no config schema, no Drush commands, no plugin types.

## What it provides
- **UI**: single page at `/admin/config/development/api-tester` (menu link under Development, `api_tester.links.menu.yml`), theme hook `api_tester_main` (`templates/api-tester-main.html.twig`), library `api_tester/main` (`js/api-tester.js`, `css/api-tester.css`).
- **Permissions** (`api_tester.permissions.yml`, both `restrict access: true`): `use api tester`, `administer api tester`. Every route requires `use api tester`.
- **Routes** (`api_tester.routing.yml`): `.main` (page), `.execute` (POST, proxies the request), `.users` (JSON user list for Test-as-User), `.list_presets`/`.save_preset` (POST)/`.load_preset`/`.delete_preset` (POST) for presets.
- **Services** (`api_tester.services.yml`): `api_tester.executor` (`Service\ApiExecutor`) and `api_tester.url_validator` (`Service\UrlValidator`).
- **Controller**: `Controller\ApiTesterController` — `main()`, `execute()`, `getUsers()`, `listPresets()`, `savePreset()`, `loadPreset()`, `deletePreset()`. Presets stored in the State API under `api_tester.presets.uid_<uid>` (per user); `execute()` can `account_switcher->switchTo()` a chosen user.
- **Hooks** (`api_tester.module`): `hook_help`, `hook_theme`. `api_tester.install`: `hook_install`/`hook_uninstall` (deletes preset state) / `hook_requirements` (checks Guzzle).

## Solution docs
- [agent/api/architecture.md](api/architecture.md) — request flow, controller endpoints, ApiExecutor, UrlValidator, presets, Test-as-User.
- [agent/config/install.md](config/install.md) — install/enable, permissions, routes, and how to operate the tool.

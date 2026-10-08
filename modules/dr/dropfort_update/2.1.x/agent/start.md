<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dropfort Update (dropfort_update) — agent index

Outbound client that POSTs this site's core **requirements/status report** and **core Update project
data** to a **Dropfort** instance (default `https://api.dropfort.com`) for centralized fleet
monitoring. Package `Dropfort`. Depends only on core **`update`**. Core `^10.1 || ^11`. License
GPL-2.0-or-later. Installed 2.1.3 (version dir 2.1.x).

## What it actually is

- No entities, no plugins, no services of its own, no Drush commands, **no inbound/callback route**.
- One admin **settings form** (`DropfortUpdateSettingsForm`) at route `dropfort_update.settings`
  (`/admin/config/services/dropfort_update`), permission **`administer dropfort update`**, menu link
  under *Configuration → services*.
- Config object **`dropfort_update.settings`** (`config/install/dropfort_update.settings.yml`); no
  `config/schema/` ships (so `provides_config_schema` is false).
- Procedural logic in `dropfort_update.module`: `hook_cron`, `hook_module_implements_alter`,
  `hook_modules_installed`, `hook_modules_uninstalled`, and the worker
  `dropfort_update_send_status()`. `dropfort_update.install` adds `hook_requirements`.
- State key `dropfort_update.last_status` records the last send time (used by `hook_requirements`).

## Solution docs

- **Settings form, config object, route, permission, menu** →
  [config/settings.md](config/settings.md)
- **The outbound reporting client — triggers, endpoint, payload** →
  [api/send-status.md](api/send-status.md)

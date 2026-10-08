<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Epsilon Harmony (epsilon_harmony) — agent index

Developers-only **client for the Epsilon Agility Harmony** marketing/customer-data APIs. Version **8.x-1.7**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Depends on core **`views`**. No composer/library deps, no submodules, no Drush.

## What it actually is

- One service **`epsilon_harmony.api_service`** → `Services\EpsilonApiFactory` (extends `Services\EpsilonConnectionFactory`). Call its methods from your own code to talk to Harmony over OAuth2. No public routes trigger the API except a credentials **Test**.
- One content entity **`epsilon_harmony_log`** (base table `epsilon_logs`) recording each API call (endpoint, method, status, header, request, response) for debugging. Admin list + canonical view + a clear-logs confirm form.
- Five admin config forms/routes under `/admin/config/epsilon_harmony`: connection settings, list-ID map, message-ID map, logs, test.
- Two permissions (`epsilon_harmony.permission.yml`): **`administer epsilon harmony`**, **`view epsilon logs`** (both `restrict access: true`).
- Config object **`epsilon_harmony.settings`** (no config/schema, no config/install shipped). Token + timeout kept in `\Drupal::state()`.

## Solution docs

- **The API service — every method, arguments, endpoints, token flow** → [api/service.md](api/service.md)
- **Configuration: settings/list/message forms, config keys, region URLs, state** → [config/settings.md](config/settings.md)
- **The log entity, routes, permissions, list/clear** → [entity/logs.md](entity/logs.md)

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Decoupled Interface Translations (decoupled_interface_translations) — agent index

Two JSON HTTP endpoints, backed by core **Locale**, for reading and registering interface (UI) strings
from a decoupled front-end. All decoupled strings live under a fixed Locale string context,
`Decoupled Translation`. Version **1.0.0**. Core `^8 || ^9 || ^10 || ^11`.

## Dependencies
- `drupal:locale` (core Locale module) — provides `locale.storage` and the source/translation string store.

## What it provides
- **Permission** (`*.permissions.yml`): `access interface translation endpoint`.
- **Routes** (`*.routing.yml`), both `_format: json`, `_auth: [basic_auth, cookie]`, `_user_is_logged_in: TRUE`,
  gated by the permission above:
  - `decoupled_interface_translations.get` — `GET /decoupled-interface-translations` → `Controller::get()`.
  - `decoupled_interface_translations.add` — `POST /decoupled-interface-translations/add` → `Controller::add()`.
- **Controller**: `src/Controller/DecoupledInterfaceTranslationsController.php`
  (services injected: `locale.storage`, `language_manager`; const `DECOUPLED_STRING_CONTEXT = 'Decoupled Translation'`).
- No config entities, no config schema, no settings form, no Drush commands, no plugins, no submodules.

## Solution docs
- [agent/api/endpoints.md](api/endpoints.md) — the two endpoints: request/response shapes, permission, auth, context.

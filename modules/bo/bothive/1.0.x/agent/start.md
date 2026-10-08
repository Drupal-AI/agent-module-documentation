<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bothive Chatbot (bothive) — agent index

Client-side loader for the third-party **bothive.be** chatbot widget. Version **1.0.4**, core `^8.8 || ^9 || ^10 || ^11`, package `Chatbot`. No modules outside core required.

## What it does
`hook_page_attachments()` (`bothive.module`) calls the `bothive.controller` service every page. `BothiveController::attachAndInitialise()` evaluates the stored `request_path` condition and, if it matches AND the API key is non-empty, attaches two libraries and pushes `apiKey`/`logging`/`hidden` into `drupalSettings['bothive']`. `js/bothive-init.js` runs `Bothive.widget.init({...})` using those settings. The widget code itself is the external script `https://widget.bothive.be`.

## Provides
- **Route** `bothive.configuration` — form `BothiveConfigurationForm`, path `admin/config/bothive`, perm `administer bothive configuration`. Also `configure:` in info.yml and a menu link (`bothive.links.menu.yml`).
- **Permission** `administer bothive configuration` (restrict access: true) — `bothive.permissions.yml`.
- **Service** `bothive.controller` = `BothiveController` (args `@config.factory`, `@plugin.manager.condition`) — `bothive.services.yml`.
- **Config** object `bothive.configuration` (`config/install/bothive.configuration.yml`): `api_key`, `logging`, `hidden`, `request_path` (core condition config). No config/schema shipped.
- **Libraries** (`bothive.libraries.yml`): `bothive-widget` = external `https://widget.bothive.be`; `bothive-initialisation` = `js/bothive-init.js` (deps core/jquery, core/drupalSettings).
- No entities, plugin types, drush commands, submodules, or server-side HTTP calls.

## Docs
- [config/settings.md](config/settings.md) — the settings form, config keys, request_path visibility, and the page-attachment flow.

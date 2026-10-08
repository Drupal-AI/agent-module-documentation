<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adopt.io Integration (adopt_io) — agent index

Injects the **GoAdOpt (Adopt.io) cookie-consent / CMP** `injector.js` script into every page. Version **1.0.0**. Core `^8 || ^9 || ^10 || ^11`. Package: Web services. No dependencies, no composer requirements.

## What it provides
- **Hook** `adopt_io_page_attachments_alter()` (`adopt_io.module`) — reads `adopt_io.settings:adopt_io_website_code`; when non-empty, attaches an `html_head` `<script>` with `src = //tag.goadopt.io/injector.js?website_code=<code>` (class `adopt-injector`). Empty code → nothing attached.
- **Settings form** `Drupal\adopt_io\Form\AdoptIoSettingsForm` (`ConfigFormBase`, form id `adopt_io_settings_form`) — one textfield `adopt_io_website_code`, saved to config `adopt_io.settings`.
- **Route** `adopt_io.configure` → `/admin/config/services/adopt_io` (`adopt_io.routing.yml`). Menu link `ows_recurring_donation.configure` under `system.admin_config_services` (`adopt_io.links.menu.yml`).
- **Config object**: `adopt_io.settings` with the single key `adopt_io_website_code`. No config schema shipped, no `config/install` defaults.

## Does NOT provide
No entities, plugins, services, blocks, permissions, drush commands, config schema, submodules, or server-side API calls. No composer.json.

## Solution docs
- [agent/config/settings.md](config/settings.md) — install/enable, the settings form, config object, the page-attachment hook, and the route/menu.

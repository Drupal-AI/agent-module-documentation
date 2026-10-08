<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CookieCuttr (cookiecuttr) — agent index

Drupal integration for the client-side **CookieCuttr jQuery plugin**: shows an EU cookie-consent bar/overlay/discreet-link on every page, driven entirely by one admin settings object. No entities, plugin types, blocks, or Drush commands.

- **Core:** `^10 || ^11`. License GPL-2.0-or-later. Version dir `2.0.x` (packaged `2.0.2`).
- **Dependency:** `js_cookie` module (provides the `js-cookie` library used to read/write the choice cookies).
- **No composer.json** in the project; nothing on Packagist beyond `drupal/cookiecuttr`.

## What it provides
- **Config form:** `Drupal\cookiecuttr\Form\CookieCuttrForm` (form id `cookiecuttr_admin_settings`, `ConfigFormBase`) editing config object `cookiecuttr.settings`.
- **Route:** `cookiecuttr.settings` → `/admin/config/user-interface/cookiecuttr`, `_permission: 'administer cookiecuttr'`, `_admin_route: TRUE`.
- **Permission:** `administer cookiecuttr` (`cookiecuttr.permissions.yml`).
- **Menu link:** `cookiecuttr.settings` under `system.admin_config_ui` (`cookiecuttr.links.menu.yml`).
- **Hook service:** `Drupal\cookiecuttr\Hook\CookiecuttrHooks::pageAttachmentsAlter()` (OOP `#[Hook('page_attachments_alter')]`, autowired in `cookiecuttr.services.yml`; legacy shim `cookiecuttr_page_attachments_alter()` in `cookiecuttr.module` marked `#[LegacyHook]`). It attaches library `cookiecuttr/cookiecuttr` and sets `$page['#attached']['drupalSettings'] = cookiecuttr_settings()`.
- **Settings mapper:** procedural `cookiecuttr_settings()` (`cookiecuttr.module`) copies each `cookiecuttr.settings` key into `drupalSettings.cookieCuttr.<pluginOption>`.
- **Assets:** library `cookiecuttr` (`cookiecuttr.libraries.yml`) = `css/cookiecuttr.css`, bundled plugin `js/jquery.cookiecuttr.js`, and glue `js/cookiecuttr.js` (calls `$.cookieCuttr(drupalSettings.cookieCuttr)`); depends on `core/jquery`, `js_cookie/js-cookie`, `core/drupal`, `core/drupalSettings`.
- **Config:** defaults `config/install/cookiecuttr.settings.yml`; schema `config/schema/cookiecuttr.schema.yml` (24 keys).

## Behavior
Runs on **every** page (page_attachments_alter, no route/path gating). The bundled jQuery plugin reads/writes first-party cookies `cc_cookie_accept` / `cc_cookie_decline` (365-day expiry) and reloads the page on accept/decline/reset. It can optionally blank Google Analytics `__utm*` cookies on decline (when `domain` is set) and `.html()`-replace named `disable` selectors with an error notice when `CookieCutter` is on. All displayed text comes from `cookiecuttr.settings` (admin config); no visitor/remote data feeds the banner.

## Solution docs
- [Configuration & settings](config/settings.md) — every config key, defaults, schema, route/permission, and the config → `drupalSettings` mapping.

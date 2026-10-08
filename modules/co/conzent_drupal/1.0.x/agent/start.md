<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conzent CMP (conzent_drupal) — agent index

**Embeds the Conzent consent-management platform (a GDPR/CCPA/ePrivacy cookie banner with IAB TCF v2.2 support) into a Drupal site, plus optional Google Tag Manager injection.**

- **Version:** 1.0.x · **Core:** `^10 || ^11` · **PHP:** 8.1 · **Package:** Conzent
- **Dependencies:** none (only `drupal/core`). No content entities, plugin types, services, or Drush commands.
- **Config object:** `conzent_drupal.settings` — keys `website_key`, `server_url`, `verified`, `gtm_id`, `data_layer` (schema in `config/schema/conzent_drupal.schema.yml`, defaults in `config/install/conzent_drupal.settings.yml`).
- **Route:** `conzent.settings` → `/admin/config/system/conzent`, `_permission: 'administer site configuration'`. Menu link in `conzent_drupal.links.menu.yml` (under System config). `configure:` in info.yml points here.
- **Form:** `src/Form/ConzentSettingsForm.php` (`ConfigFormBase`) — collects the settings and, on save, calls the Conzent API to verify the website key.
- **Permission:** `administer conzent` (`restrict access: true`) declared in `conzent_drupal.permissions.yml` (present but not used to gate the route — the route uses the core config permission).
- **Front-end injection:** `conzent_drupal_page_attachments()` in `conzent_drupal.module` adds the banner `<script src="{server_url}/c/consent.js" data-key="{website_key}">` to `<head>` only when a key is set and `verified === 'yes'`; when `gtm_id` is set it also injects the GTM loader + noscript iframe.
- **Uninstall:** `conzent_drupal_uninstall()` deletes the config object.

## Solution docs
- [config/settings.md](config/settings.md) — install/enable, the settings form, config keys, verification flow, and how the banner/GTM scripts are attached.

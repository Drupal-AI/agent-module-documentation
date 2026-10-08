<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synapse Staff (synapse) — agent index

Injects **Google Tag Manager**, a **GA4** measurement ID, and **Google/Yandex Webmaster** site-verification meta tags. Version **2.0.x** (installed 2.0.4). Core `^11 || ^12`. Package `Synapse`. No external deps, no submodules.

## What it provides
- **Config form** `synapse.settings` at `/admin/config/synapse/settings` (`\Drupal\synapse\Form\Settings`, a `ConfigFormBase`), gated by permission `administer site configuration`. Menu link under `system.admin_config_system`.
- **Config object** `synapse.settings` with keys: `gtm-id`, `ga4-id`, `gtm-admin-disable`, `wm-yandex`, `wm-google`. Ships `config/install/synapse.settings.yml` (only `gtm-id`, `wm-yandex`, `wm-google` seeded, empty). No config schema shipped.
- **Hooks** (thin `.module` wrappers delegating to `src/Hook/`):
  - `hook_page_attachments()` → `\Drupal\synapse\Hook\PageAttachments::hook()` — appends `google-site-verification` and `yandex-verification` `<meta>` tags to `#attached[html_head]` when the respective config value is set.
  - `hook_preprocess_html()` → `\Drupal\synapse\Hook\PreprocessHtml::hook()` — injects the GTM `<script>` into `page_bottom` (weight 999) when `gtm-id` is set, the path is not under `/admin/`, and not suppressed for user 1.

## No entities / permissions / services / plugins / drush.

## Solution docs
- [config/settings.md](config/settings.md) — settings form, config keys, output behavior.

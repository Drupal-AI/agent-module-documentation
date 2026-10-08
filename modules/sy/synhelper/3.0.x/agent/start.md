<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synapse Helper (synhelper) — agent index

Multi-purpose site-building helper for Synapse/Synatix Drupal sites. Version **3.0.x** (info.yml `3.0.2`).
Core `^11 || ^12`. Package **Synapse**. Depends on the **`idna`** module. No permissions of its own; ships
config schema and Drush commands. Superseded major of the older `8.x-2.x` branch.

## What it does
- SEO no-index (site-wide, `1c.*` subdomain, and fixed sensitive paths) + status-report requirement.
- FZ-152 / GDPR personal-data consent checkbox on contact forms and the user register form.
- Cookie-consent notice; shipped `/policy` and `/demo-page` pages.
- Yandex Metrica counter injection + Yandex Ecommerce dataLayer events + per-form conversion goals.
- `contact_message` normalization; Commerce checkout/product alters; upload filename transliteration.
- Commerce/content YAML export & import services; Drush + Console CLI commands.

Behavior is driven from one settings form; there are no plugin types. Logic lives in hook classes under
`src/Hook/`, services under `src/Service/`, utilities under `src/Utility/`, CLI under `src/Drush/Commands/`
and `src/Command/`.

## Config
- Single config object `synhelper.settings` (schema `config/schema/synhelper.schema.yml`,
  defaults `config/install/synhelper.settings.yml`). See [config/settings.md](config/settings.md).

## Routes
- `synhelper.settings` → `/admin/config/synapse/synhelper` (`administer site configuration`), the rest are
  read-only pages under `access content`. See [routes/pages.md](routes/pages.md).

## Services (`synhelper.services.yml`)
- `synhelper.content_exporter`, `synhelper.content_importer`, `synhelper.yandex_ecommerce`,
  `synhelper.contact_message_normalizer`. See [services/services.md](services/services.md).

## Hooks
- ~20 hook implementations wired in `synhelper.module` to classes in `src/Hook/`.
  See [hooks/hooks.md](hooks/hooks.md).

## Drush / Console
- `drush.services.yml` (`synhelper.commands`) and `console.services.yml` (`synhelper:export`).
  See [drush/commands.md](drush/commands.md).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drupal_cms_helper — agent start

Glue module bundled with Drupal CMS. Provides recipe-developer tooling, config-action
plugins, opt-in telemetry, and shims for things not yet in core. No config UI of its own;
declares no module dependencies; should not be uninstalled on a Drupal CMS site. Only a small
part of its surface is a stable API (`@api`) — most classes are `@internal` and will be
removed as core issues land.

Capabilities (read the doc for the one you need):

- **Drush commands** (export a site as a recipe, generic config export, content export/import,
  site archive, clean disabled packages) → [drush/commands.md](drush/commands.md)
- **Config-action plugins** for recipes (`setDefaultImage`, `themeDevelopmentMode`,
  `setComponentTree`, and internal `grantPermissionsIfExist` / page-variant create) →
  [plugins/config-actions.md](plugins/config-actions.md)
- **Programmatic API** — the `SiteExporter` service and the site-export route →
  [api/site-exporter.md](api/site-exporter.md)
- **Telemetry** — opt-in anonymous usage events sent to Amplitude →
  [internals/telemetry.md](internals/telemetry.md)

Quick facts:
- Headline command: `drush site:export` (aliases `siex`, `six`).
- Recipe-ready config export: `drush config:export --generic` (strips `_core` + `uuid`).
- Download-site-as-ZIP route: `/admin/config/development/site-export` (perm: `administer site configuration`).
- `@api` config actions: `setDefaultImage`, `themeDevelopmentMode`, `setComponentTree`.
- Requires Composer packages `drupal/core:^11.4` and `davereid/drupal-environment:^1.2`.

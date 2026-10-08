<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drupal_cms_helper — agent start

Glue module bundled with Drupal CMS. Provides recipe-developer tooling and shims for things
not yet in core. No config UI of its own; depends only on `path_alias`; should not be
uninstalled on a Drupal CMS site. Only a small part of its surface is a stable API
(`@api`) — most classes are `@internal` and will be removed as core issues land.

Capabilities (read the doc for the one you need):

- **Drush commands** (export a site as a recipe, generic config export, content export/import, site archive) → [drush/commands.md](drush/commands.md)
- **Config-action plugins** for recipes (`setDefaultImage`, `themeDevelopmentMode`, and internal `grantPermissionsIfExist` / `overrideMenuLinks`) → [plugins/config-actions.md](plugins/config-actions.md)
- **Programmatic API** — the `SiteExporter` service and the site-export route → [api/site-exporter.md](api/site-exporter.md)

Quick facts:
- Headline command: `drush site:export` (aliases `siex`, `six`).
- Recipe-ready config export: `drush config:export --generic` (strips `_core` + `uuid`).
- Download-site-as-ZIP route: `/admin/config/development/site-export` (perm: `administer site configuration`).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# e-Plikt (eplikt) — agent index

RSS export for Swedish legal-deposit (mandatory delivery). Two feed routes list published entities
gathered by pluggable **source** plugins and render them as RSS 2.0 with Dublin Core metadata, per
the National Library of Sweden delivery spec. Version **1.0.4**, core `^11`, GPL-2.0-or-later.

**Dependencies:** core `media`, `media_entity_download`. No composer.json, no libraries, no
permissions/Drush of its own, no config schema.

## What it provides

- **Feeds & routes** (`EpliktController`): `GET /eplikt/all` and `GET /eplikt/weekly` (weekly =
  changed within 7 days). Both `_permission: access content`, `Content-Type:
  application/rss+xml`. → [feeds/feeds.md](feeds/feeds.md)
- **Plugin type `eplikt_source`** (annotation `@EpliktSource`, manager
  `plugin.manager.eplikt_source`, base `EpliktSourceBase`, interface `EpliktSourceInterface`).
  Ships **Node** (`node_source`) and **Media** (`media_source`) plugins. → [plugins/source.md](plugins/source.md)
- **Settings** (`SettingsForm`, route `eplikt.settings` at `/admin/config/services/eplikt`,
  `administer site configuration`): config object `eplikt.settings` = `publisher`, `access_rights`,
  `sources` + per-source subkeys. → [config/settings.md](config/settings.md)
- **Theme hooks & templates** (`ThemeHooks`): `eplikt_rss`, `eplikt_rss_item`,
  `eplikt_rss_item__media`; preprocess via legacy `template_preprocess_*` in `eplikt.module`. →
  [feeds/feeds.md](feeds/feeds.md)
- **Service** `plugin.manager.eplikt_source` (extends `default_plugin_manager`).
- **hook_help** (`Hooks::help`) renders README on `help.page.eplikt`.

## Not present

No entity types, fields/formatters/widgets, blocks, permissions, Drush commands, config schema,
submodules, or external HTTP calls.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Track (config_track) — agent index

Logs every configuration change into a revision history. Package `Configuration`. Core
`^10.3 || ^11.1`. Version `1.0.0-alpha4` (alpha). No module dependencies (uses `language`
opportunistically if present). No permissions.yml, no settings, no config schema, no Drush.
Note: the info.yml display label is **"Config Revision"**; project/machine name is `config_track`.

## What it actually is

- An **event subscriber + decorated module handler** that captures config writes and stores them
  as rows in a custom `config_track` DB table, plus a **two-route admin UI** to list and diff them.
- No entities, no plugins, no fields, no forms. The only user-facing surface is the report at
  `/config-revisions` gated by core permission **`administer site configuration`**.

## Provides

- **Routes** (`config_track.routing.yml`): `config_track.config_track.overview` → `/config-revisions`
  (list); `config_track.config_track.single` → `/config-revisions/{revision_id}` (diff). Both
  `_admin_route`, both require `administer site configuration`.
- **Menu link** (`config_track.links.menu.yml`): under `system.admin_config_development`.
- **Services** (`config_track.services.yml`): `config_track_subscriber`
  (`EventSubscriber\ConfigTrackSubscriber`); a private decorator of `module_handler`
  (`Extension\ModuleHandler`, decoration_priority 9).
- **DB schema** (`config_track.install` `hook_schema`): table `config_track` — `revision_id`
  (serial PK), `timestamp`, `uid`, `operation`, `collection`, `name`, `data` (serialized blob),
  `debug_backtrace` (blob).
- **Hooks** (`config_track.module`): `hook_help`, and four entity hooks
  (`config_track_entity_presave_first/_last`, `config_track_entity_predelete_first/_last`)
  invoked in a forced order by the decorator.

## Solution docs

- **How capture works, the table, install baseline** → [architecture/capture.md](architecture/capture.md)
- **The report UI, routes, permission, diff rendering** → [routes/overview-and-diff.md](routes/overview-and-diff.md)

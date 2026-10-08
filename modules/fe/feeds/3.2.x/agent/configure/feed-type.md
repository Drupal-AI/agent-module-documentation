# Feed types, mapping & settings

A **feed type** is a `feeds_feed_type` config entity (`config_prefix: feed_type`, config name
`feeds.feed_type.<id>`). It bundles exactly one plugin of each type plus the field mapping.

UI: **Admin → Structure → Feed types** (`/admin/structure/feeds`,
route `entity.feeds_feed_type.collection`). Key sub-pages:

| Page | Route | Purpose |
|---|---|---|
| Edit | `entity.feeds_feed_type.edit_form` | choose fetcher/parser/processor + their settings, import period |
| Mapping | `entity.feeds_feed_type.mapping` | map source elements → target field plugins, set unique keys |
| Sources | `entity.feeds_feed_type.sources` | define custom/named sources (e.g. CSV columns) |

Concepts on a feed type:
- **Fetcher** — where data comes from: `http`, `upload`, `directory`.
- **Parser** — how it is read: `syndication` (RSS/Atom), `csv`, `opml`, `sitemap`.
- **Processor** — what is created: `entity:node` and generic `entity:<type>` processors.
- **Mapping** — array of `{target, map, unique, settings}`; mark a target `unique` so existing
  entities are updated (keyed by e.g. GUID/URL) instead of duplicated.
- **Import period** — seconds between cron imports (`-1` = off / manual only).

Global module config is minimal: `feeds.settings` holds `lock_timeout` (default `43200`s) —
how long an import may hold its lock. Read/write with
`drush config:get feeds.settings` / `drush config:set feeds.settings lock_timeout 3600`.

The instances/config for each plugin are stored under the feed type's `fetcher_configuration`,
`parser_configuration`, `processor_configuration` keys (see `config/schema/feeds.schema.yml`).
Feed types are exportable config, so build once and deploy across environments.

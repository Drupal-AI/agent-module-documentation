<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Discovery & site: schema dump, site info, search

## Schema — `wm:schema:*` (`SchemaCommands` + `SchemaManager`)

The onboarding command set: one call gives an agent a full YAML picture of the site.

| Command | Aliases | Args / options |
|---|---|---|
| `wm:schema:dump` | `wm-sd`, `wm:s:dump` | `--section` (repeatable; default = all sections) |
| `wm:schema:sections` | `wm-ss`, `wm:s:sections` | — (list section names) |

`SchemaManager::dump()` aggregates other managers into sections (constant `SECTIONS`):
`ai-onboarding`, `content-types`, `vocabularies`, `media-types`, `entity-types`, `menus`, `views`,
`blocks`, `site`. Invalid `--section` values are rejected with the list of valid ones. The
`ai-onboarding` section is a static guide describing the file-first edit/apply workflow, discovery
commands, token-efficient read patterns, and the versioning layout — output for agent consumption,
not live data. `SchemaCommands` is also constructed with `SetupCommands` (`@drush_webmaster.commands.setup`)
so a schema dump can note whether the AI skill files are installed.

## Site settings — `wm:site:*` (`SiteCommands` + `SiteManager`)

Reads/writes a small slice of `system.site` config.

| Command | Aliases | Options |
|---|---|---|
| `wm:site:info` | `wm-si`, `wm:s:info` | — |
| `wm:site:update` | `wm-su`, `wm:s:update` | `--name --slogan --mail --page-front --page-403 --page-404 --dry-run` |

`SiteManager::getInfo()` returns name, slogan, mail, front/403/404 paths, admin_compact_mode,
weight_select_max, default_langcode. `updateInfo()` maps the six writable options onto
`system.site` config keys (`page.front`, `page.403`, `page.404`, etc.), records a before/after diff,
honours `--dry-run`, and saves via `@config.factory`.

## Search — `wm:search` (`SearchCommands` + `SearchManager`)

| Command | Aliases | Args / options |
|---|---|---|
| `wm:search` | `wm-s` | `keywords` + `--type(node_search) --limit(10) --page(0)` |

Runs Drupal **core Search** (the `search` plugin named by `--type`, default `node_search`) and
returns results as YAML with title, URL and snippet. `SearchManager` uses `@entity_type.manager`,
`@renderer` and `@module_handler`; it requires the core Search module and a configured/indexed
search page. Use `wm:entity:query` for exact field-level filtering and `wm:search` for keyword
discovery.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynImport — Drush commands

All operation is via Drush (`\Drupal\synimport\Drush\Commands\SynimportCommands`). Run from the Drupal root (`cd web && drush …`).

## Import (reads a directory of YAML files)
| Command | Scope |
|---|---|
| `drush synimport <dir>` | Full import (menu, taxonomy, nodes, products, blocks) |
| `drush synimport:contact <dir>` | Contacts page only |
| `drush synimport:node <dir>` | Nodes only |
| `drush synimport:menu <dir>` | Menus + links only |
| `drush synimport:taxonomy <dir>` | Taxonomy terms only (children nested under parents) |
| `drush synimport:product <dir>` | Commerce products only |
| `drush synimport:block <dir>` | Custom blocks only |
| `drush synimport:synlanding_config <dir>` | Synlanding config only |

Target bundles/fields must already exist — synimport does not create or validate them.

## Export (writes a directory of YAML files + `/files`)
| Command | Args |
|---|---|
| `drush synexport <dir> <status>` | Full export; status 1=published, 0=unpublished |
| `drush synexport:node <dir> <type> <status>` | Nodes of a bundle |
| `drush synexport:product <dir> <type> <status>` | Products of a bundle |
| `drush synexport:taxonomy <dir> <status>` | Taxonomy terms |

## Directory layout
`<dir>/contacts`, `<dir>/block`, `<dir>/node`, `<dir>/product`, `<dir>/taxonomy`, `<dir>/synlanding`, plus `<dir>/files` for binaries. See the module's `content file examples/` for concrete YAML.

## Field typing
Typed fields use `{type: <t>, content: <v>}` with `<t>` ∈ image, media, attach, taxonomy, paragraph, variations, attribute. Untyped fields are written as `field_name: value`; unknown types fall back to text.

## Network behaviour during import
- Field values beginning with `http` are fetched server-side via `file_get_contents` and saved to `public://import/` (`Import/Files.php`).
- `Import/Redis.php` fetches visit-card/brief JSON from `app.biz-panel.com`/`biz-panel.com` using a week-based token.

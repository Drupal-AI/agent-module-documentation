<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Drush commands

All commands are Symfony console commands registered under the `tome:` namespace (they extend
`Drupal\tome_base\CommandBase`). Run them from the site root. Provided by `tome_sync` and
`tome_static`.

## Content / config / files — `tome_sync`
| Command | Does |
|---|---|
| `drush tome:export` | Exports **all** config, content, and files to disk (initial export). Options: `--process-count`, `--entity-count`, `-y`. |
| `drush tome:import` | Imports all config, content, and files from disk (run after `drush si <profile> -y`). Same options. |
| `drush tome:import-partial` | Imports only content/config/files that changed since last import (uses content hashes). |
| `drush tome:export-content <type:id>[,<type:id>...]` | Exports specific entities, e.g. `node:1`, `user:1`. Writes `<dir>/<entity_type>.<uuid>.json`. |
| `drush tome:import-content <type:uuid:langcode>` | Imports specific content items. |
| `drush tome:delete-content <type:id[:langcode]>` | Deletes content / removes translations from the export. |
| `drush tome:import-complete` | Fires the `tome_sync.import_all` event (post-import hooks). |
| `drush tome:clean-files [-y]` | Deletes exported files that are no longer referenced by any content/config. |

## Static HTML — `tome_static`
| Command | Does |
|---|---|
| `drush tome:static` | Renders every public path to static HTML in the static directory. Key options: `--uri=<absolute-url>` (**important** — without it absolute URLs may be wrong), `--path-pattern=<preg>` (export only matching paths), `--process-count`, `--path-count`, `--retry-count`, `--run-server`, `--port`, `--ignore-warnings`, `-y`. |
| `drush tome:static-export-path <comma,paths>` | Renders one chunk of paths (used internally by `tome:static`; also usable directly). |
| `drush tome:preview [--port=8889] [--open=1]` | Serves the generated static directory with PHP's built-in server. |

Notes:
- `tome:static` sets/reads state key `tome_static.building` (a build-in-progress guard) and
  records the last build URL in state key `tome_static.url`.
- `tome:super-cache-rebuild` / `tscr` is defined by `tome_static_super_cache` but is **only**
  registered for Drupal Console (no `drush.command` tag) — on a Drush-only site use the
  "Fully clear caches" button at `/admin/config/development/performance` instead.

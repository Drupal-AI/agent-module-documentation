<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands & the assets report

## Drush commands

Live commands are the annotated service `library_manager.commands` →
`Drupal\library_manager\Commands\LibraryManagerCommands` (registered in `drush.services.yml`,
args `@library_manager.library_discovery`, `@serialization.yaml`, `@http_client`, `@state`).

| Command | Aliases | Does |
|---|---|---|
| `lm:list` | `lm-l`, `lm-list` | Table of every registered library (name, version, licence) via `libraryDiscovery->getLibraries()`. Default fields name,version. |
| `lm:export <library_id>` | `lm-e`, `lm-export` | Prints one library's YAML (`exportLibraryByName()` → `serialization.yaml->encode()`). `<library_id>` is `extension/library`; throws `UnexpectedValueException` if not found. |
| `lm:cache-clear` | `lm-cc`, `lm-cache-clear` | `libraryDiscovery->clearCachedDefinitions()`. |
| `lm:check-assets` | `lm-ca`, `lm-check-assets` | Iterates every library's css+js files, resolves each to an absolute URL (`file_url_generator` for `type: file`, the raw url for `type: external`), GETs it with the Guzzle `http_client`, and prints a Found/Error table; records `library_manager_assets_check_timestamp` in state. |

`library_manager.drush.inc` is a legacy **Drush 8** `hook_drush_command()` shim providing the same
`lm-list` / `lm-export` / `lm-cache-clear` / `lm-check-assets` callbacks; on modern Drush the
annotated service is what runs.

## The assets report (`/admin/reports/libraries`)

`Drupal\library_manager\Form\AssetsCheckForm` (form id `assets_report_form`, route
`library_manager.assets`, permission **`access site reports`** — the one route not behind
`administer libraries`). It shows "Last check … ago" from the
`library_manager_assets_check_timestamp` state value and a **Check assets** button. On submit it
builds a Batch: for every library's css/js file it enqueues the file's absolute URL (or the external
url) and, in `processBatch()`, does `\Drupal::httpClient()->get($url)` — a success counts the asset
as loadable, a `GuzzleException` adds a warning naming the failed link. `finishBatch()` stores the
timestamp and reports "Loaded N of M". This is the UI equivalent of `drush lm:check-assets`: a
link-checker that confirms every asset URL a library references is reachable, useful after editing
external/CDN URLs or moving generated files.

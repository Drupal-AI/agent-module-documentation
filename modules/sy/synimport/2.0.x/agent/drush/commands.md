<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SynImport — Drush commands

All operation is via Drush. Command class: `\Drupal\synimport\Drush\Commands\SynimportCommands`, wired in `drush.services.yml` (service `synimport.commands`, injects `synimport.log`, `synimport.export`, `synimport.import`). Names below are declared with `#[CLI\Command]`; the alias equals the command name in every case. Run from the Drupal root (e.g. `cd web && drush …`, or `ddev drush …`).

## Import commands (read a directory of YAML files)

| Command | Arguments (defaults) | Method → service call |
|---|---|---|
| `synimport <directory>` | directory | `import()` → `Import::import()` — full import in order: contacts, menu, taxonomy, nodes, products, block, synlanding |
| `synimport:redis_import <app_id> <source>` | app_id, source | `redisImport()` → `Import::redisImport()` → `Redis::import()` |
| `synimport:contacts <directory>` | directory | `importContacts()` → `Import::importContacts()` |
| `synimport:taxonomy <directory>` | directory | `importTaxonomy()` → `Import::importTaxonomy()` |
| `synimport:node <directory>` | directory | `importNode()` → `Import::importNode()` |
| `synimport:menu <directory>` | directory | `importMenu()` → `Import::importMenu()` |
| `synimport:product <directory>` | directory | `importProducts()` → `Import::importProducts()` |
| `synimport:block <directory>` | directory | `importBlocks()` → `Import::importBlocks()` |
| `synimport:synlanding_config <directory>` | directory | `setSynlandingFormBg()` → `Import::setSynlandingFormBg()` |

Every import command except `synimport:redis_import` first calls the private `dirIsEmpty()` guard, which throws `EmptyDirException` if the path does not exist, is not a directory, or contains no files (only `.`/`..`/`.svn`/`.git`). Target bundles and fields must already exist — SynImport never creates or validates content types or fields.

## Export commands (write a directory of YAML files + `<dir>/<entity_type>/` + `<dir>/files/`)

| Command | Arguments (defaults) | Method → service call |
|---|---|---|
| `synexport <directory> [status=1]` | directory, status | `export()` → `Export::export()` — taxonomy, node (`node`), product (`commerce_product`), block (`block`) |
| `synexport:taxonomy <directory> [status=1]` | directory, status | `exportTaxonomy()` → `Export::exportTaxonomy(dir,'taxonomy_term',status)` |
| `synexport:node <directory> [bundle=node] [status=1]` | directory, bundle, status | `exportNode()` → `Export::exportNode()` |
| `synexport:product <directory> [bundle=commerce_product] [status=1]` | directory, bundle, status | `exportProducts()` → `Export::exportProducts()` |
| `synexport:block <directory> [bundle=block] [status=1]` | directory, bundle, status | `exportBlocks()` → `Export::exportBlocks()` |

- **status**: `1` exports only entities with `status = 1`; `0` skips the status condition (exports all). See `CreateYmlBase::initQuery()` — the query uses `accessCheck(FALSE)`, which is fine for a trusted CLI export.
- **bundle**: pass an entity-type machine name (e.g. `node`, `commerce_product`, `block`) to export all its bundles, or a single bundle machine name (e.g. `article`) to export just that bundle (`CreateYml::checkBundle()`).

## Directory layout for a full import
`Import::import()` looks for these subdirectories under `<directory>`:
`/contacts`, `/menu`, `/taxonomy`, `/nodes`, `/products`, `/block`, `/synlanding` (missing/empty ones are skipped with a warning). Per-type import commands instead take the direct path to the folder of `.yml` files. See the module's `content file examples/` for concrete YAML samples.

## Logging
`synimport.log` (`Service\Logger`) prints colored `[HEAD]/[INFO]/[NOTICE]/[WARNING]/[ERROR]/[SUCCESS]` lines to stdout via `print_r`. Diagnostics from `Files` also go to the core logger channel `synimport`.

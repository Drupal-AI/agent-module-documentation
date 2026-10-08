<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

`src/Commands/D7ImportCommands.php`, registered in `drush.services.yml`
(service `d7_import.commands`, class constructed with all seven importer services, tag
`drush.command`). CLI only — no Drupal route or permission gate; runs with the shell user's
Drush access. Uses Drush attribute syntax (`Drush\Attributes as CLI`).

## Commands

| Command | Alias | Argument | Purpose |
|---------|-------|----------|---------|
| `d7-import:all` | `d7iall` | directory | Run every stage from a dir of XML files |
| `d7-import:vocabularies` | `d7iv` | taxonomy.xml | Create vocabularies |
| `d7-import:terms` | `d7it` | taxonomy.xml | Import terms (TID-preserving, hierarchy-ordered) |
| `d7-import:content-types` | `d7ict` | nodes.xml | Create content types + fields + displays |
| `d7-import:files` | `d7if` | files.xml | Create file entities (`--source-path` copies bytes) |
| `d7-import:nodes` | `d7in` | nodes.xml | Import nodes (NID-preserving) |
| `d7-import:aliases` | `d7ia` | aliases.xml | Import URL aliases |
| `d7-import:menus` | `d7im` | menus.xml | Import menus + menu links |
| `d7-import:purge` | `d7purge` | — | Delete imported content (see options) |

## `d7-import:all`

`drush d7-import:all /path/to/export/` — reads `taxonomy.xml`, `nodes.xml`, `files.xml`,
`aliases.xml`, `menus.xml`, `webforms.xml` from the directory and runs each stage in dependency
order (vocabularies → terms → content-types → files → nodes → aliases → menus → webforms). Each
file is optional; a stage is skipped if its file is absent.

Options: `--source-files=/path/to/d7/files` (copy managed files), and per-stage
`--skip-vocabularies`, `--skip-terms`, `--skip-content-types`, `--skip-files`, `--skip-nodes`,
`--skip-aliases`, `--skip-menus`, `--skip-webforms`.

Webforms only run if `webforms.xml` exists **and** `\Drupal::hasService('d7_import_webform.webform_importer')`
(i.e. the `d7_import_webform` submodule is enabled). The base module has no hard dependency on
webform — the service is resolved dynamically through the container.

## `d7-import:content-types`

Besides the `nodes.xml` argument it auto-loads a sibling `taxonomy.xml`
(`dirname($file).'/taxonomy.xml'`) if present, so `taxonomy_term_reference` fields can be bound to
their source vocabulary.

## `d7-import:purge`

Flags: `--nodes`, `--terms`, `--vocabularies`, `--files`, `--menus`, `--aliases`, `--all`. Errors
out if none given. Calls each importer's `purgeAll()`. Menu purge also deletes custom menus but
preserves core menus (`main`, `footer`, `admin`, `tools`, `account`).

## XML loading (`loadXmlFile` / `sanitizeXmlContent`)

Unlike the form, the Drush path reads the file with `file_get_contents`, strips invalid XML 1.0
control chars (`preg_replace('/[\x00-\x08\x0B\x0C\x0E-\x1F]/', '', $content)` — keeps tab/newline/CR),
then `\DOMDocument::loadXML()` with `libxml_use_internal_errors(TRUE)`; parse errors are logged
line-by-line. Legacy D7 exports frequently contain such control chars, hence the sanitiser.

## Notes

- `displayResult()` prints imported / updated / skipped counts and per-error warnings.
- The command docblock lists a recommended run order; `d7-import:all` applies it automatically.
- README recommends running long imports under tmux/screen/nohup and optionally
  `php -d memory_limit=2G $(which drush) d7-import:all …`.

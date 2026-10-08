<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin forms, routes, permissions, module functions

Everything in `chadol` outside the storage-client plugin
([../plugins/storage-client.md](../plugins/storage-client.md)): 3 routes, 2 forms, 1 JSON controller,
3 permissions, and 3 procedural helpers. No config/install, no Drush, no cron, no update hooks.

## Permissions (`chadol.permissions.yml`)

- `view chado content` — "Allows clients to use view any Chado content."
- `edit chado content` — "Allows clients to modify any Chado content."
- `administer chado` — "Allows access to Chado administration froms." (sic)

## Routes (`chadol.routing.yml`)

- **`chadol.admin`** — `/chadolight/admin`, form `\Drupal\chadol\Form\ChadoLightAdminForm`.
  `_permission: 'administer site configuration,administer chado'` (comma = **any** of them grants
  access). Menu link `system.chadol_management` under *Configuration → Content* (Content Authoring);
  local task "Overview".
- **`chadol.add_content_type`** — `/chadolight/admin/structure/types/add`, form
  `ChadoLightAddContentTypeForm`, same permission. Local task "New Chado Content Type".
- **`chadol.autocomplete`** — `/chadolight/autocomplete/{dbkey}/{schema}/{type}/{params}`,
  `\Drupal\chadol\Controller\AutocompleteController::handleAutocomplete`, `_format: json`.
  `_permission: 'administer site configuration,administer chado,view chado content'` (any of the
  three). Route constraints: `dbkey` `\w+`, `schema` a PostgreSQL identifier regex, `type` `\w+`;
  `params` defaults to empty.

## ChadoLightAdminForm (`src/Form/ChadoLightAdminForm.php`)

Overview page. `create()` grabs `config.factory` (editable `chadol.settings` — currently only saved
empty by `submitForm`), `entity_type.manager`, `dbxschema.tool`.

- Lists detected Chado instances: iterates `Database::getAllConnectionInfo()`, and for each pgsql
  `default` target calls `chadol_get_available_instances()`, rendering a table of db key / schema /
  version / data-size (`ByteSizeMarkup`) / built-in-type buttons.
- `getBuiltinForm($dbkey, $schema)` shows, per built-in type (db, dbxref, cv, cvterm, pub, organism),
  either a **create** submit button or an edit link to the existing external entity type
  (id from `chadol_get_builtin_type_id()`).
- Lists existing Chado content types: queries `external_entity_type` storage (with `accessCheck(TRUE)`)
  and shows any type whose storage client is `xnttchado`, or `xnttdb` pointed at a Chado schema, with
  edit + collection links.

## ChadoLightAddContentTypeForm (`src/Form/ChadoLightAddContentTypeForm.php`)

Label + `machine_name` fields and a "Create and configure" button. **`validateForm` and `submitForm`
are empty stubs** (`@todo`) — the form does not yet create anything in this beta.

## AutocompleteController (`src/Controller/AutocompleteController.php`)

`handleAutocomplete($request, $dbkey, $schema, $type, $params)` returns a `JsonResponse` of
`{value,label}` suggestions (max 20). Backs the cvterm/organism pickers in the plugin's filter forms.

- Reads term from query `?q=`; empty → empty JSON. Applies `Xss::filter()` then
  `$connection->escapeLike()`, and binds it only as the `:value` placeholder.
- Validates `dbkey` is a known pgsql connection, `schema` passes `dbxschema.tool->isInvalidSchemaName()`
  and is an actual Chado instance (`chadol_get_available_instances`); otherwise returns empty JSON.
- `type` cases: `cvterm` / `cvterms` (comma list), `phylonode`. `params` selects a sub-query via
  regexes: `cv-<id>`, `children-<id>`, `descendent-<id>` (recursive CTE), `table-type_id-<name>`,
  `table-cvterm_id-<name>`. Numeric captures are digits; table-name captures are `\w+` placed inside a
  `{1:<name>}` dbxschema identifier. Runs a prefix match then a substring match to top up results;
  DB errors are caught and logged to the `chadol` channel.

## Module functions (`chadol.module`)

- `chadol_find_chado_version(CrossSchemaConnectionInterface, ?$schema, $exact)` — detects whether a
  schema is Chado (counts ~16 signature tables) and returns its version (from `chadoprop`, else
  guessed by table/column presence), `'0'`, or `''`.
- `chadol_get_available_instances(CrossSchemaConnectionInterface)` — lists non-system schemas that are
  Chado, with `version`, `has_data` (size > `CHADOL_EMPTY_CHADO_SIZE` = 8 MiB), and `size`.
- `chadol_get_builtin_type_id($table, $dbkey, $schema)` — `chadol_<dbkey>_<schema>_<table>` (non-word
  chars in dbkey/schema replaced by `_`).

## Assets

`chadol.libraries.yml` defines `chadol/global-styling` (`css/chadol.css`), attached by both the admin
form and the plugin config form.

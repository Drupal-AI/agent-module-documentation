<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The admin log view, routes, permission, filter, CSV export, clear-log

## Permission (single gate)

`content_modification_log.permissions.yml` defines one permission,
`administer content_modification_log settings` (`restrict access: true`). **Every** route below
requires it — there is no separate "view log" vs "administer" split.

## Routes (`content_modification_log.routing.yml`)

| route | path | handler | perm |
|---|---|---|---|
| `content_modification_log.report` | `/admin/reports/content-modification-log` | `…ExportController::content` | administer content_modification_log settings |
| `content_modification_log.content` | `/admin/reports/content-modification-log` (dup, "Modifications" title) | `…ExportController::content` | same |
| `content_modification_log.settings` | `/admin/config/content/content-modification-log` | `ContentModificationLogSettingsForm` | same |
| `content_modification_log.export` | `/admin/content/content-modification-log/export` | `…ExportController::export_csv` | same |
| `content_modification_log.delete` | `/admin/config/content/content-modification-log/delete` | `ContentModificationLogConfirmDeleteForm` | same |

Menu links (`*.links.menu.yml`): log view under `system.admin_reports`, settings under
`system.admin_config_content`. A `content_modification_log.content.tab` local task
(`*.links.task.yml`) on `system.admin_content` is stripped unless `show_tab` is on.

## The HTML log view — `ContentModificationLogExportController::content()`

`src/Controller/ContentModificationLogExportController.php`.

- Reads `start` / `end` query params, runs each through `strtotime()` (end gets `+1 day`).
- Embeds `ContentModificationLogFilterForm` at `$build['filter_form']`.
- Builds a DBTNG select on `content_modification_log` (alias `cml`), extended with
  `TableSortExtender`, joined to `users_field_data` (`ufd`) on `cml.uid = ufd.uid` for the author
  name. Date conditions are applied with parameterised `->condition('timestamp', …, '>=' | '<=' |
  'BETWEEN')`.
- `orderByHeader($header)` sorts by the clicked column (header fields are hardcoded, default sort
  `cml.timestamp desc`). Paged via `PagerSelectExtender->limit($page_rowcount)` where
  `$page_rowcount = $config->get('cml_rowcount') ?: 50` (see gotcha below → effectively 50).
- For each row: node rows get a `Link` to `/node/{id}`, file rows a `Link` to the file URL
  (`createFileUrl()`), each only when the entity still loads; the author cell is a `Link` to
  `/user/{uid}`, or the literal `System Updates` when `uid == 0`.
- Output is a `#type => table` render array (`#header`, `#rows`, `#empty`) plus a `#type => pager`.
  Cell values are plain strings or `Link` objects → escaped by the table theme.

## Filter form — `ContentModificationLogFilterForm`

`src/Form/ContentModificationLogFilterForm.php` (`FormBase`, id `content_modification_log_filter_form`).
Fields: an "Export to CSV" submit (`#name` `export_results`), a Dates `details` with `start_date`
and `end_date` `#type => date` (defaulted from the `start`/`end` query params), and Filter / Reset
submits. `submitForm()` redirects by triggering button: `filter_results` → the log view with `start`/
`end` query; `export_results` → `content_modification_log.export` with the same query; anything else
→ the log view with no filters ("Filters cleared").

## CSV export — `ContentModificationLogExportController::export_csv()`

Runs the same select (no pager), builds rows with a `$header` of
`lid, uid, username, timestamp, client_ip, entity_id, entity_title, revision_log_message,
entity_type, entity_bundle, entity_url, action`, writes them with `fputcsv()` into a memory stream,
converts to `iso-8859-2`, and saves the CSV under the filename from
`$config->get('cml_csv_filename') ?: 'content-log.csv'` (token-replaced via the `token` service),
then shows a status message and redirects back to the log view (preserving the date range). Returns a
`RedirectResponse`. Write exported logs to a private, non-web-accessible location.

## Clear the log — `ContentModificationLogConfirmDeleteForm`

`src/Form/ContentModificationLogConfirmDeleteForm.php` (`ConfirmFormBase`). The settings form links
here ("Clear Log Data" button → route `content_modification_log.delete`). Confirming (POST + form
token) runs `\Drupal::database()->truncate('content_modification_log')->execute()`, shows "The
Content Modification Log has been cleared.", and redirects to settings. Cancel returns to settings.
There is no per-row deletion — it is all-or-nothing truncate.

## Block + menu-link extras

- `ContentModificationLogBlock` (`src/Plugin/Block`, id `content_modification_log`): a block whose
  only setting is a free-text `content_modification_log_field`; `build()` renders the
  `content_modification_log` theme with that value passed as `#content.cid` and
  `drupalSettings.json_url`, attaching `content_modification_log/content_modification_log.functions`.
  It does not render the log itself (the JS/template are a stub container).
- `ContentModificationLogContentLink` (`src/Plugin/Menu`): a `MenuLinkDefault` whose `isEnabled()`
  returns false unless `content_modification_log.settings:show_tab === 1`.

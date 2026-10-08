<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart 404 — Drush commands

`src/Drush/Commands/Smart404Commands.php` (attribute-based `DrushCommands`, `AutowireTrait`). Drush is
a dev/optional dependency (`composer.json` `require-dev` + `suggest`); the commands work whenever Drush
is present. Injected: `Smart404Repository`, `Smart404RedirectCreator`, `DateFormatterInterface`.

| Command (alias) | Purpose |
|---|---|
| `smart404:list` (`s404-list`) | List logged 404 rows. |
| `smart404:cleanup` (`s404-cleanup`) | Run retention cleanup now (calls `Smart404Repository::cleanup()`). |
| `smart404:redirect <id> <destination>` (`s404-redirect`) | Create a redirect for a logged path. |

## `smart404:list`

Options `--status` (new|ignored|resolved), `--host` (partial), `--min-hits`, `--limit` (default 50).
Uses `Smart404Repository::findFiltered()` (no pager — pager needs a real request). Default fields:
id, path, host, hits, status, last_seen (a `RowsOfFields`, so `--format`/`--fields` work).
Example: `drush smart404:list --status=new --min-hits=5`.

## `smart404:cleanup`

No args. Deletes rows past `retention_days`, prunes the daily table, and enforces `max_records` — the
same logic cron runs, but immediately.

## `smart404:redirect <id> <destination>`

`--status-code` (301 or 302, default 301). Loads the record by id (fails with `CommandFailedException`
if missing), then runs the shared `Smart404RedirectCreator::validate()` — the CLI is the one caller
where a non-301/302 `invalid_status_code` is reachable, since the web forms use a `<select>`. On a
validation error it throws a `CommandFailedException` with a matching message
(`invalid_destination`, `same_path`, `redirect_loop`, `source_resolves`, `source_has_query_string`,
`invalid_status_code`). Warns (but proceeds) if a redirect already exists for the source, then calls
`create()`, which also marks the log record resolved.
Example: `drush smart404:redirect 42 /about-us --status-code=301`.

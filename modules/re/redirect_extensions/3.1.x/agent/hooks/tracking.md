<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect authorship / timestamp tracking

Core Redirect entities do not record who created or last changed them. This module keeps a
side table, `redirect_extensions`, and populates it from Redirect's entity hooks so the
`url_redirects` View can show created-by / created / modified columns.

## The table (`hook_schema` in `redirect_extensions.install`)

| Column | Type | Meaning |
|---|---|---|
| `aid` | serial, PK | surrogate primary key |
| `rid` | int unsigned | the redirect's `rid` (soft FK to `{redirect}.rid`) |
| `uid_created` | int unsigned | user id recorded on the row (see caveat) |
| `created` | int (unix ts) | first insert time |
| `modified` | int (unix ts) | last update time |

## The hooks (`redirect_extensions.module`)

- `hook_redirect_insert($redirect)` → `insertRedirect($rid)`.
- `hook_redirect_update($redirect)` → if `redirectExists($rid)` then `updateRedirect($rid)`
  else `insertRedirect($rid)` (self-heals rows created before this module was on).
- `hook_redirect_delete($redirect)` → `deleteRedirect($rid)`.

All three call the service `redirect_extensions.redirect_storage`.

## The service

`Drupal\redirect_extensions\RedirectDatabaseStorage` (implements
`RedirectDatabaseStorageInterface`), id `redirect_extensions.redirect_storage`, constructed
with `@database`, `@current_user`, `@datetime.time`.

| Method | Effect |
|---|---|
| `insertRedirect($rid)` | insert row: `rid`, `uid_created` = current user, `created` = `modified` = request time |
| `redirectExists($rid)` | count-query on `rid`, returns bool |
| `updateRedirect($rid)` | update row for `rid`: set `uid_created` = current user, `modified` = request time |
| `deleteRedirect($rid)` | delete the row for `rid` |

All queries use the DB API builder with placeholder `condition('rid', $rid, '=')` /
`fields()`; `$rid` comes from the redirect entity's own `rid` value, not request input.

## Caveats for integrators

- `updateRedirect()` rewrites `uid_created` with the **editing** user, so after any edit the
  column reflects the last editor, not the original author (the column name is misleading).
  `created` is never changed after insert.
- `RedirectDatabaseStorage` type-hints
  `Drupal\mysql\Driver\Database\mysql\Connection` in its constructor — it is bound to the
  **MySQL** driver and will not resolve on a PostgreSQL/SQLite site.
- The table is not an entity and holds no destination/URL data; it is metadata keyed by
  `rid` only.

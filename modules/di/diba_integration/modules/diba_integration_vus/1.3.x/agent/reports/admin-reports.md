<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# diba_integration_vus — admin reports & Oracle lookup

Three report pages under `/admin/config/people/vus/` cross-check Drupal accounts against the corporate Oracle mailbox directory. All are gated by the `access vus` route permission. Source: `Controller/BaseVusController`, `BustiesController`, `CountsController`, `ErrorsController`, `Service/DibaOracleService`, `Form/BustiesFilterForm`.

## Oracle service — `Service/DibaOracleService`
- `createOracleConnection()` — `oci_connect(_user_oracle, state:oracle_password, _db_oracle, 'AL32UTF8')`; returns NULL if credentials missing, FALSE/NULL on error (logged to channel `diba_integration_vus`). Then runs `SET ROLE ALL` (`setOracleRole`). This is a native OCI DB connection, not HTTP.
- `fetchUsernamesByEmail()` / `fetchEmailsByUsername()` — join `VUS_BUSTIES_USR`/`VUS_USUARIS` (type `P`), returning `username_by_email` and `mail_by_username` maps. Usernames are `ops$`-prefixed for the query and stripped in the result.
- `executeBatchQuery()` — chunks input into batches of 200 and binds each value with `oci_bind_by_name(':<prefix><n>', $value)` (parameterized; no string-concatenated user input in the SQL).
- `buildOracleStatusBlock()` — renders a status banner; all interpolated strings pass through `Html::escape` + `Markup::create`.
- `loadDibaDataWithConnection()` / `countUsersWithDibaEmailByDomain()` — open, use, and immediately `oci_close` a connection.

## Busties report — `BustiesController::content` (`/vus/busties`)
Lists Drupal users with columns username / mail / status / last access / DiBa username / DiBa mail / username-match / mail-match. Reads GET params via `RequestStack`: `filter` (name/mail CONTAINS), `match_filter` (`user_yes|user_no|mail_yes|mail_no`), `page_size` (whitelisted set {25,50,100,200,500,1000,10000}, else 50). With a match filter it loads all matching users, fetches Oracle data, filters in PHP (`filterUsersByMatch`/`shouldSkipRow`), and paginates manually via `pager.manager`; otherwise it uses a DB-paged `entity query` (`->accessCheck(FALSE)`, `tableSort`). Account names link to `entity.user.edit_form`. `Form/BustiesFilterForm` is a GET-redirect filter form (submit sets query params on `diba_integration_vus.busties`).

## Counts report — `CountsController::content` (`/vus/counts`)
Statistics via count queries (`->accessCheck(FALSE)`): total users, users on `_diba_domains` (mail LIKE `%domain`), users with an Oracle mailbox broken down by domain, external users (no Oracle mailbox) by domain, and access recency tiles (accessed / never / last 30 days / last 365 days). Percentages via `number_format`; every dynamic string in the tile markup is `Html::escape`d before `Markup::create`.

## Errors report — `ErrorsController::content` (`/vus/errors`)
Loads all users, fetches Oracle data, and lists accounts where the Drupal username or email does not match the corporate directory (`collectErrors` flags a mismatch only when both a Drupal and an Oracle value exist and differ). Requires a working Oracle connection; otherwise shows an error message.

## Notes for agents
- All three controllers use `->accessCheck(FALSE)` on their user entity queries; access is enforced by the route `_permission: access vus` (a restricted admin-diagnostics permission), so the reports intentionally show every account regardless of the viewer's per-entity access.
- The reports are read-only (no mutation routes); the only state-changing form here is the filter form, which redirects with GET query parameters.

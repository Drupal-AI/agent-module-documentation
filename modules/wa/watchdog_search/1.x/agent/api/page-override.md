<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page override, search & filters — `DbLogController`

All logic lives in `src/Controller/DbLogController.php`
(`Drupal\watchdog_search\Controller\DbLogController extends Drupal\dblog\Controller\DbLogController
implements FormInterface`). It is wired to the core log page by the route subscriber, not by a
routing file.

## How the takeover happens

1. `Routing\RouteSubscriber::alterRoutes()` gets the `dblog.overview` route and calls
   `$route->setDefault('_controller', '…\DbLogController::buildPage')`. Access requirements are
   **not** modified — the page keeps core's `access site reports` permission.
2. `ConfigOverride::loadOverrides()` sets `views.view.watchdog` `status => FALSE`, so the core
   Views report is disabled and this controller owns `/admin/reports/dblog`.

## `buildPage()` (the render array)

- Attaches `dblog/drupal.dblog` (core's log CSS/JS + AJAX modal behavior).
- `$build['form'] = $this->formBuilder()->getForm($this)` — the controller renders *itself* as the
  filter form (`getFormId()` = `watchdog_search_db_log`).
- Builds a `#type => table` (header from `buildHeader()`, rows from `buildRows()`) with
  `#empty => 'No log messages found.'`, plus a `#type => pager`.

## The filter form — `buildForm()`

Adds fields, all populated from the current query string via `getQueryParam()`:

- `search` — textfield (`#default_value` = `?search`).
- `type` — multi-select of `_dblog_get_message_types()`.
- `severity` — multi-select of `RfcLogLevel::getLevels()`.
- `from` / `to` — `datetime` elements.
- `actions.submit` ("Apply filters") and `actions.clear` ("Reset filters", `#submit =
  ['::clearFilters']`).

`submitForm()` calls `$form_state->cleanValues()` then `setRedirect('<current>', …)` with the
non-empty values, i.e. it turns the submit into a plain **GET redirect that puts the filters in the
URL query string** (so results are bookmarkable/shareable). `clearFilters()` redirects to
`<current>` with no params. `validateForm()` is a no-op.

## The query — `getData(array &$header)`

Builds `SELECT … FROM {watchdog}` extended with `PagerSelectExtender` + `TableSortExtender`,
selecting `wid, uid, severity, type, timestamp, message, variables, link`, `leftJoin`ed to
`users_field_data` on `uid`. Filters:

- **Search**: `?search` is `trim()`-ed and split on spaces; each term is AND-ed as its own
  `orConditionGroup`. Within a group it matches `wid = term`, and for eight case variations of the
  term (as-is / lower / upper / ucfirst, each also with non-`[a-zA-Z0-9_ -]` stripped) it matches
  `users_field_data.name = variation`, `message LIKE %variation%`, and `variables LIKE
  %variation%`. All are placeholder conditions; the `LIKE` patterns are wrapped with
  `$this->database->escapeLike($variation)`.
- **type** / **severity**: `condition('type'/'severity', $value, 'IN')` when present.
- **from** / **to**: `new DrupalDateTime($from|$to)->getTimestamp()` compared `>=` / `<=` against
  `timestamp`.
- `->limit(50)` and `->orderByHeader($header)`.

Returns `fetchAll(\PDO::FETCH_ASSOC)`.

## The rows — `buildRows(array &$header)`

For each record it renders the core-formatted message (`$this->formatMessage()`, inherited),
truncates it (`Unicode::truncate(Html::decodeEntities(strip_tags($message)), …)`) for the visible
link text, and builds a `#type => link` to `dblog.event` (`event_id => wid`) carrying `use-ajax` +
`data-dialog-type => modal` so the full message opens in a modal (the dialog title includes the wid
and a `match()`-mapped `RfcLogLevel` severity label). The User cell themes `#theme => username` for
the loaded account; the Operations cell renders the stored `link` field; a "View" link repeats the
`dblog.event` target. Row classes come from `Html::getClass('dblog-'.type)` and
`getLogLevelClassMap()`.

## Query-param helper & version shim

`getQueryParam($key, $multiple = FALSE)` reads from the request stack; on Drupal 10/11 with
`$multiple` it uses `query->all($key)` (for the multi-selects), otherwise `query->get($key)`.
`isDrupal9()` gates that on `(int) floatval(\Drupal::VERSION) === 9`.

## Operate

- Enable `watchdog_search` (core `dblog` is a dependency) and go to `/admin/reports/dblog`; the
  page is now the searchable version with no further setup.
- There is **no** settings form, permission, config object or schema shipped by this module —
  everything is driven by the URL query string on the standard report page.
- To go back to the stock Views report, disable this module (the `views.view.watchdog` override and
  route rewrite are removed with it).

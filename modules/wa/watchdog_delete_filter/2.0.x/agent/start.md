<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Watchdog Delete Filter (watchdog_delete_filter) — agent index

Selectively deletes **dblog / watchdog** log entries by **Type** and/or **Severity**, replacing core
Dblog's all-or-nothing "Clear log messages" confirm page. **There is no age/date filter** (that is a
different module, Watchdog Prune). Depends on core `dblog`. Version **2.0.2**.
Core requirement `^8 || ^9 || ^10 || ^11`. No configuration; no permission of its own; no Drush command.

## Mechanism (from source)

- `watchdog_delete_filter.services.yml` registers `WatchdogDeleteRouteSubscriber`
  (`src/Routing/WatchdogDeleteRouteSubscriber.php`), an event subscriber that, in `alterRoutes()`,
  takes the existing core route **`dblog.confirm`** (path `admin/reports/dblog/confirm`) and overrides
  only its `_form` default to `\Drupal\watchdog_delete_filter\Form\WatchdogDeleteForm`. The route's
  `_permission: 'access site reports'` requirement is **unchanged** — access is exactly what core uses
  to clear the whole log.
- `src/Form/WatchdogDeleteForm.php` (a `ConfirmFormBase`):
  - `buildForm()` runs `SELECT DISTINCT(type) FROM {watchdog}` to populate a `#multiple` **Type**
    select, and `RfcLogLevel::getLevels()` to populate a `#multiple` **Severity** select. A "Select
    all" `<input type="button">` plus `js/watchdog_delete_filter.js` (jQuery) selects every option in
    both lists. A "Reset" button is a native form reset.
  - `submitForm()` counts rows matching the chosen types and (separately) the chosen severities, then
    builds one `$this->connection->delete('watchdog')` and adds `->condition('type', array_values($types), 'IN')`
    and/or `->condition('severity', array_values($severities), 'IN')` for whichever filters have
    matches. Both filters set ⇒ conditions are **AND-ed**. No filter selected ⇒ no delete
    ("If filters are not used, none messages will be deleted.").
  - The success message `"Database log cleared (@cnt entries)."` uses `cnt_types + cnt_severities`
    (two independent counts summed) — so when both filters are used it **over-reports** the rows the
    AND-query actually deletes. Cosmetic bug, not a data-integrity issue.
- No `config/`, no schema, no hook_install; the `.module` only provides `hook_help` text.

## Security note for operators (not a code vulnerability)

A log is evidence. This form makes it easy to remove one *class* of entries (a type, a severity) and
leave a log that still looks complete, whereas core's full clear is conspicuous. Where dblog is your
only record and you have an audit obligation, ship logs to append-only storage and treat
`access site reports` as an audit-relevant grant. The query construction itself is safe (parameterized
`IN` conditions; standard Drupal form CSRF token via `ConfirmFormBase`).

## Files

- `data.json` — metadata (category: Administration tools / Database maintenance / optimization).
- `usage.md` — short summary, dense mechanism paragraph, use-case bullets.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Watchdog Delete Filter replaces core's all-or-nothing "Clear log messages" confirm page with two multi-select filters — **Type** and **Severity** — so you can delete just the matching database-log (dblog / watchdog) entries and keep the rest. There is **no age/date filter**; deletion is by type and/or severity only.

---

Core's Dblog gives one destructive control at `admin/reports/dblog/confirm`: wipe every log entry. That makes routine cleanup impossible without losing the whole record, yet the need is real — a misconfigured module writing a warning on every request buries everything else, a resolved incident leaves thousands of identical entries, a noisy channel drowns the entries an administrator actually watches for. This module registers a route subscriber that swaps the `_form` on the existing `dblog.confirm` route (still gated by core's `access site reports` permission) for its own `WatchdogDeleteForm`. That form reads the distinct `type` values currently in the `{watchdog}` table and the standard `RfcLogLevel` severities, presenting each as a multi-select; a small "Select all" JS button selects every option in both lists. On submit it builds a single `DELETE FROM {watchdog}` with the selected values applied as parameterized `IN` conditions — `type IN (...)` and/or `severity IN (...)`. If **both** filters are set the conditions are **AND-ed** (rows must match a selected type *and* a selected severity); if only one is set, only that condition applies; if neither is set, nothing is deleted (the form says so explicitly). One behavioral caveat: the "N entries" success message sums two independent counts (rows matching the type filter plus rows matching the severity filter), so when both filters are used the reported number over-states the rows actually removed by the AND query — treat it as approximate. Version **2.0.2**, core `^8 || ^9 || ^10 || ^11`, depends on core `dblog`, no configuration. Because a log is evidence, keep in mind that anyone who can reach this page can remove specific classes of log entries and leave a log that still looks complete — where dblog is your only record, ship logs somewhere append-only and treat this permission as audit-relevant; where the real problem is log volume, the durable fix is the module doing the noisy logging, not repeated deletion.

---

- Delete every entry of one noisy log type (e.g. `cron`, `php`, a chatty custom channel) while keeping the rest.
- Remove all `debug`- or `notice`-severity entries after finishing a debugging session.
- Keep `error` and `critical` entries and drop everything of lower severity.
- Clear the flood of identical warnings left by a resolved incident so real errors are visible again.
- Trim a bloated `{watchdog}` table configured to retain 100000+ rows.
- Delete entries matching a specific type *and* a specific severity together (both filters AND-ed).
- Remove entries from a single module type before handing the log to someone for review.
- Clean up after a misconfigured module that logged on every request.
- Reduce the size of a database backup/export by pruning noise from dblog first.
- Drop `info`/`notice` chatter but preserve the warning/error history.
- Delete the `page not found` (404) entry type when a scanner has filled the log.
- Remove `access denied` noise from a bot storm.
- Use the "Select all" button to preselect every type and severity, then deselect the few you want to keep.
- Selectively purge a deprecated module's log type after uninstalling it.
- Keep dblog usable on a long-running site without ever wiping the whole log.
- Delete only the highest-volume type to reclaim table space quickly.
- Prune multiple types at once (multi-select) in a single operation.
- Prune multiple severities at once in a single operation.
- Prepare a focused log view by removing categories irrelevant to the current investigation.
- Recommend installing Chosen to make the Type/Severity multi-selects searchable when there are many types.
- Confirm nothing is deleted by submitting with no filters selected (safe no-op).

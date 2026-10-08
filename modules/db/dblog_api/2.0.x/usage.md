Database logging API (dblog_api) is a small developer framework that lets modules add their own "Operations" links or markup to each log row shown by Drupal core's Database logging (dblog) module.

---

The module defines a `DblogOperation` plugin type and swaps core's watchdog Views "link" field handler for its own (`dblog_api_operations`). Core's field handler renders only the built-in "view" detail link in the operations column of the `admin/reports/dblog` overview (a `watchdog`-based View). The replacement handler still renders that "view" link, then iterates over every registered `DblogOperation` plugin, calls `shouldDisplay()` to ask whether the plugin applies to the current row, and appends the render array returned by `displayOperation()` when it does. Each plugin receives the Views `ResultRow` for the log entry so it can decide, per row, what operation to show (for example a re-run, acknowledge, or deep-link action tied to the logged event). The module ships no routes, no permissions, no configuration, and no services beyond the plugin manager and the Views-data hook — it is purely an extension point for other modules to build on.

---

- Add a custom "Operations" action (link, button, or markup) to rows on the `admin/reports/dblog` log overview.
- Provide a per-row deep link from a log entry to the entity or admin page the event relates to.
- Show an "acknowledge" or "mark handled" affordance next to specific error log rows.
- Add a "re-run" / "retry" operation for rows logged by a queue or batch process.
- Surface a link to an external monitoring or ticketing system for matching log messages.
- Filter which rows get an extra operation by inspecting the row's `type` (channel) in `shouldDisplay()`.
- Filter by severity so an operation only appears for warnings or errors.
- Add different operations for different logging channels from separate plugins.
- Extend the operations column without patching or overriding core's dblog Views handler.
- Let multiple modules each contribute their own operation to the same log row independently.
- Render a contextual action only when the log row references a known entity id.
- Provide a "copy details" or "open backtrace" link for developer-oriented log channels.
- Link a PHP/error log row to the relevant code location or issue tracker.
- Add a moderation or escalation action to security-related log channels.
- Give editors a quick "view content" jump from content-related log entries.
- Build admin tooling that reacts to logged events directly from the reports screen.
- Alter the set of available operation plugins via the `dblog_api_operation` alter hook.
- Cache plugin definitions automatically through the standard plugin manager cache backend.
- Register operation plugins with a simple annotation (`@DblogOperation`) and an `id`.
- Provide the Drupal 7 → later migration state marker so upgrade paths recognize the module.
- Serve as a reference implementation of replacing a core Views field handler with a plugin-driven one.

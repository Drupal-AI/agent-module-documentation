<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# devel_debug_log — agent start

**Developer-only debugging aid.** You call the global `ddl($message, $title)` (or `ddl_once()`)
from PHP, or the `ddl()` function inside Twig; each call appends a row to a small custom DB table
(`devel_debug_log`). Read the collected messages at **`admin/reports/debug`** (Reports → Debug
messages), newest-first with a pager and a **Clear log messages** button. Persists across requests —
built for AJAX/redirect/cron/subrequest debugging where on-screen messages don't help.

Hard-depends on `devel:devel` (^5.1) + `serialization`. `configure` = null (no settings). No config
entities, no plugin types, no Drush, no invitable hooks. Not for production.

- Call `ddl()` / `ddl_once()` from PHP, and `ddl()` from Twig; what's stored and how it renders →
  [api/ddl.md](api/ddl.md)
- The one permission that gates the debug page → [permissions/permissions.md](permissions/permissions.md)

Key names: functions `ddl(mixed $message, string $title = '')`, `ddl_once(...)` (defined in
`devel_debug_log.module`); Twig function `ddl(value, title)` (`src/Twig/DevelDebugLogExtension.php`,
no-op unless `twig.config:debug` is TRUE); route `devel_debug_log.list` → `admin/reports/debug`;
permission `access debug messages` (`restrict access: TRUE`); DB table `devel_debug_log`
(id, timestamp, title, message, serialized); theme hook `devel_debug_log_list`
(`templates/devel-debug-log-list.html.twig`, renders each `message` with `|raw`). Array/object
messages are dumped via `plugin.manager.devel_dumper` using `devel.settings:devel_dumper` (Kint by default).

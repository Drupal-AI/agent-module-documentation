<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Object Log lets developers stash the contents of any variable under a label and inspect it later from an admin report.

---

The module provides a logging helper that serializes and stores a value (with a label and timestamp) in an `object_log` table, plus a report UI under `/admin/reports/object_log` (list) and `/admin/reports/object_log/{label}` (detail), both gated by Devel's `access devel information` permission. On the detail page the stored value is read back with a parameterized query and `unserialize()`d for display. It depends on the Devel module and is intended for local/development debugging, not production.

Because entries are written only by developer code calling the logging API (there is no web-facing write path), and both report routes require the developer-only `access devel information` permission, the stored data is not attacker-writable. The `unserialize()` of stored blobs is a standard debug-tool pattern here rather than an exposed sink — keep the module disabled on production as with Devel itself.

---
- Dump a complex variable and inspect it later in the UI.
- Debug values that are hard to view inline (large arrays/objects).
- Compare a variable's state across multiple code paths by label.
- Log intermediate values during a batch or queue run.
- Inspect data captured deep in a request without dpm() spam.
- Keep a labelled history of debug snapshots.
- Review stored dumps at an admin report page.
- Trace a bug by logging objects at several points.
- Share a captured value with another developer on the same site.
- Avoid cluttering the message area with debug output.
- Persist debug data beyond a single request.
- Examine serialized structures rendered readably.
- Complement Devel's inline tools with stored snapshots.
- Clear the log when finished debugging.
- Capture values from CLI/Drush code paths for later viewing.
- Investigate intermittent issues by accumulating labelled dumps.

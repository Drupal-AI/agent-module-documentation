<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Recur SS

Provides an alternative "interpreter" for the Date Recur module — the component that turns an RRULE recurrence rule into a readable sentence (e.g. "Every second Tuesday").

- Adds a `DateRecurInterpreter` plugin (`SsInterpreter`) selectable in Date Recur's interpreter config.
- Extends/complements the default interpreter with a different rendering implementation.
- Purely a display/formatting concern for recurring date fields.

---

## Installation & configuration

- Requires the **date_recur** module (>= 3.2) and PHP 8.0+.
- Enable it, then create/configure a Date Recur interpreter that uses the `ss` plugin.
- Assign that interpreter to your date_recur field's formatter settings.
- No permissions or routes of its own.
- Configuration is done through Date Recur's existing interpreter UI.
- Ships an `.install` file for any schema/setup needs.

---

## Usage & behaviour

- The plugin class is `src/Plugin/DateRecurInterpreter/SsInterpreter.php`.
- It receives a set of RRULE occurrences/rules and returns a human-readable string.
- No database access, no external calls, no request handling.
- Interpreters are pure formatting logic — no access-control surface.
- Use it when the default Date Recur interpreter's wording does not suit your locale/style.
- Multiple interpreters can coexist; choose per formatter.
- Tests live under `tests/`.
- Works with the standard date_recur field type and widgets.
- Output is text intended for display next to the recurring date.
- No user-supplied data is trusted for anything beyond formatting.
- Being a plugin, it is discovered automatically once enabled.
- Combine with date_recur's field formatter to show the rule summary.
- Depends entirely on date_recur's data model.
- No configuration schema beyond the interpreter entity provided by date_recur.
- Read: `src/Plugin/DateRecurInterpreter/SsInterpreter.php`.

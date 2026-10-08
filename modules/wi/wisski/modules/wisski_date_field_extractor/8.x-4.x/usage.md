<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Date Field Extractor provides a field type and a presave hook that turn recorded date expressions into calculable values.

---

Historical dates are not timestamps. "Second quarter of the 15th century", "before 1523", "c. 1780–1790", "reign of Elizabeth I" are all normal catalogue entries and none of them is a date a database can sort or filter. The usual result is a collection whose dates are prose: readable, and useless for any query that involves time.

This submodule addresses that by extracting calculable values from what the cataloguer recorded, so a record keeps its expert expression *and* gains something a range query can use.

The design question it embodies is one every collection faces: whether to force cataloguers into a structured date field they will misuse, or let them write what they mean and derive structure from it. The second is more respectful of the material and produces better data, provided the derivation is inspectable — a date silently interpreted wrongly is worse than one left as text, because it will be trusted.

Worth checking on any collection using it: how ambiguous expressions are resolved, and whether the derived range is visible to cataloguers so they can correct a bad interpretation.

---

- Record a historical date as an expression.
- Make an approximate date sortable.
- Filter a collection by date range.
- Handle "before" and "circa" dates.
- Keep the cataloguer's own wording.
- Derive a range from a date expression.
- Sort objects chronologically.
- Query a collection by period.
- Check how ambiguous dates are resolved.
- Show the derived range to cataloguers.
- Correct a misinterpreted date.
- Avoid forcing structured date entry.
- Audit dates that failed to parse.
- Plan date modelling for a collection.
- Support uncertainty in historical dating.

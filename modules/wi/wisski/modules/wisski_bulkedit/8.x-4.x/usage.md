<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Bulk Edit applies updates to many records from a CSV file.

---

Corrections in a research collection arrive in batches. A specialist reviews four hundred attributions and returns a spreadsheet; a reconciliation run produces identifiers for two thousand names; a cataloguing error is found and affects every record entered in a month. Doing those one record at a time is not viable.

This submodule applies them from CSV, which is the format the people producing the corrections actually work in.

**Two safeguards to insist on.** Back up the triple store first — a bulk edit against a semantic store is not straightforwardly undoable, and a mistake in the mapping affects every row. And run against a copy first with a sample, because the failure mode of bulk editing is not an error message; it is several thousand records quietly updated with the wrong value in the right field.

**This module ships under the project's `legacy/` directory**, so establish whether it is the current recommended path before building a workflow on it.

---

- Apply corrections from a spreadsheet.
- Update many records at once.
- Load reconciled identifiers in bulk.
- Fix a cataloguing error across a month's records.
- Work in the format specialists use.
- Back up before a bulk edit.
- Test against a copy first.
- Run a sample before the full set.
- Avoid silently wrong bulk updates.
- Check its legacy directory status.
- Establish the current recommended path.
- Audit what a bulk edit changed.
- Roll back an incorrect bulk edit.
- Plan a correction workflow.
- Reduce manual editing effort.

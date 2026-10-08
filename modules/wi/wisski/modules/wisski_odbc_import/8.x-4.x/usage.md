<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI ODBC Import reads data from an external database over ODBC, for migrating existing catalogues.

---

Most WissKI projects start with an existing catalogue: an Access database, a FileMaker file, an institutional system nobody has the source for. Getting that data across is the first and often largest task, and ODBC is the lowest common denominator that most of those systems can speak.

This submodule reads over ODBC so a legacy catalogue can be pulled in rather than exported to CSV and reshaped by hand.

**The hard part of this work is not the transport, and documentation should say so.** Reading rows over ODBC is straightforward; mapping a flat catalogue onto an ontology is not. A column called "Date" that contains "c. 1780", "18thC" and "1780-90" in different rows, a "Maker" column with names, workshops and "unknown" mixed together, a notes field carrying half the actual information — every legacy catalogue has these, and resolving them is the project.

Plan the import as an iterative process against a copy: import, inspect, fix the mapping, re-import. A single-pass migration from a real legacy catalogue does not happen.

---

- Import a legacy catalogue over ODBC.
- Read from an Access or FileMaker database.
- Migrate an institutional system into WissKI.
- Avoid manual CSV reshaping.
- Map a flat catalogue onto an ontology.
- Handle inconsistent date columns.
- Separate makers from workshops in a column.
- Extract information from a notes field.
- Iterate an import against a copy.
- Inspect results and fix the mapping.
- Plan migration as the main project task.
- Estimate migration effort realistically.
- Preserve legacy identifiers.
- Audit what did not map.
- Re-import after a mapping change.

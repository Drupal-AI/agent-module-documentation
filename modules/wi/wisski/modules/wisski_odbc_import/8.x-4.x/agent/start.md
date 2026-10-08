<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI ODBC Import (wisski_odbc_import) — agent index

Submodule of **wisski**. Imports data over **ODBC** — the lowest common denominator most legacy
catalogues speak. Version **8.x-4.3**. Core `>=10.4 <12`.

**Say plainly that the transport is not the hard part.** Reading rows is straightforward; mapping a
flat catalogue onto an ontology is not. Every legacy catalogue has a "Date" column holding
"c. 1780", "18thC" and "1780-90"; a "Maker" column mixing names, workshops and "unknown"; and a
notes field carrying half the actual information. **Resolving those is the project.**

Plan it as **iterative against a copy** — import, inspect, fix mapping, re-import. A single-pass
migration from a real legacy catalogue does not happen.
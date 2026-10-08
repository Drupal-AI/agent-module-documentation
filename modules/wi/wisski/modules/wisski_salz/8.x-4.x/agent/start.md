<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI SALZ (wisski_salz) — agent index

Submodule of **wisski**. **Store Abstraction Layer Zero** — adapter management and the common data
interface. Version **8.x-4.3**. Core `>=10.4 <12`.

Hides which store a record's data lives in. A WissKI install typically reads from a project SPARQL
store **plus** authority services (GND, Getty AAT, GeoNames, Zotero); SALZ makes them one source.

Supplies the **query annotator and planner** `wisski_core` uses. The planning step is where a
multi-adapter query is decomposed, dispatched and recombined — the difference between a research
database that responds and one that times out.

**Extension point for a new store type** — implement the adapter interface here rather than
teaching `wisski_core` about a backend.

**First place to look** when data lands in the wrong store, will not save, or is inconsistent
between two views of the same record.
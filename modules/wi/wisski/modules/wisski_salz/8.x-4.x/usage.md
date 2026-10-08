<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI SALZ — Store Abstraction Layer Zero — is the layer that hides which store a record's data actually lives in.

---

A WissKI installation typically reads from more than one place: a SPARQL triple store holding the project's own data, plus authority services like GND, Getty AAT, GeoNames or Zotero that supply reference data. SALZ is what makes those look like one data source to everything above it.

It manages the adapter plugins, routes reads and writes to the right one, and supplies the query annotator and planner that `wisski_core` uses to turn entity queries into store queries. The planning step matters more than it sounds: a query spanning several adapters has to be decomposed, sent to each and recombined, and doing that badly is the difference between a research database that responds and one that times out.

For anyone extending WissKI, this is where a new store type is added — implement the adapter interface here rather than teaching `wisski_core` about a new backend.

Because SALZ mediates every read and write, it is also the layer to look at first when data appears in the wrong place, does not save, or comes back inconsistently between two views of the same record.

---

- Abstract several stores behind one interface.
- Read project data from a SPARQL store.
- Read reference data from an authority service.
- Combine data from several adapters.
- Plan a query across multiple stores.
- Route a write to the correct adapter.
- Add a new store type as an adapter.
- Diagnose data appearing in the wrong store.
- Investigate a record that will not save.
- Debug inconsistent results between views.
- Understand WissKI's query pipeline.
- Configure which adapter holds which data.
- Keep the frontend independent of storage.
- Extend WissKI without touching the core.
- Tune query performance across stores.

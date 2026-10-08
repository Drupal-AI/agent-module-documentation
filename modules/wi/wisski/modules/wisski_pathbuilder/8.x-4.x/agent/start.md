<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Pathbuilder (wisski_pathbuilder) — agent index

Submodule of **wisski**. **Maps Drupal fields onto paths through an ontology** (typically
CIDOC-CRM). Version **8.x-4.3**. Core `>=10.4 <12`.
Required by `wisski_core` and by `wisski_adapter_sparql11_pb`.

**The intellectual centre of WissKI.** A field called "Date of production" means nothing to a
store; a *path* — object → was produced by → production event → has time-span → begins — means
something a machine can reason about and another institution can consume.

This is why WissKI differs from a content type with a SPARQL exporter: the ontology model comes
first and fields are projections of it, so data is conformant **by construction**.

**Treat the pathbuilder as a versioned, reviewed artefact.** A path is a modelling decision
affecting every record under it; changing one after data exists is a **migration**, not an edit.
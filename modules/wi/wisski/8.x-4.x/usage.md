<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI is a virtual research environment: Drupal entities whose data lives in a SPARQL triple store and is mapped onto a formal ontology, so a museum or research project can record scholarly data in ordinary forms and get standards-conformant linked data out.

---

The acronym is German — *Wissenschaftliche KommunikationsInfrastruktur*, scientific communication infrastructure — and the audience is memory institutions: museums, archives, libraries and research groups that need to collect, manage and publish scholarly data over decades. It began as a joint project of the Digital Humanities group at FAU Erlangen-Nuremberg, the Germanisches Nationalmuseum and the Zoologisches Forschungsmuseum Alexander Koenig.

Architecturally it is one of the more ambitious things in contrib. `wisski_salz` (Store Abstraction Layer Zero) abstracts storage behind adapters; `wisski_adapter_sparql11_pb` speaks SPARQL 1.1 to a triple store; `wisski_pathbuilder` maps Drupal fields onto paths through an ontology such as CIDOC-CRM, which is what turns a form field into a triple with real semantics; `wisski_core` supplies the entity type, routing and UI. Around that sit adapters for authority files (GND, Getty AAT, GeoNames, SKOS, Zotero), a REST API, IIIF viewers (Mirador, IIP Image), DOI minting, duplicate detection and merging, statistics and permalinks — roughly thirty submodules in all.

**This release cannot be enabled on a site without core's Search module, and the failure is a full outage.** `wisski_core.services.yml` injects `@search.search_page_repository` into `wisski.route_subscriber`, while `wisski_core.info.yml` declares only `inline_entity_form`, `wisski_autocomplete`, `wisski_pathbuilder` and `wisski_salz` — `drupal:search` is not among them. **Verified:** enabling it produced *"The service `wisski.route_subscriber` has a dependency on a non-existent service `search.search_page_repository`"* on every request, and Drush could not run either, so the site could not be repaired with Drush. Adding `search` to `core.extension` directly cleared that error; a partially installed `wisski_title_n_grams` table then produced a second failure. **Enable core Search before WissKI.** Because of this the documentation here is written from source rather than from a running install.

Nothing about that is a reason to dismiss the project — it is a serious, long-lived research platform — but it is the first thing to get right, and a one-line addition to the info file would prevent it.

---

- Model museum collection data against CIDOC-CRM.
- Store scholarly records in a SPARQL triple store.
- Map Drupal fields onto ontology paths with the pathbuilder.
- Publish research data as linked open data.
- Let researchers in different places work on one collection.
- Reconcile names against the GND authority file.
- Reconcile terms against Getty AAT.
- Reconcile places against GeoNames.
- Import a SKOS vocabulary as authority data.
- Pull bibliographic records from Zotero.
- Serve collection data over a REST API.
- Display images with a IIIF viewer (Mirador).
- Mint DOIs for records.
- Detect and merge duplicate records.
- Produce statistics over a collection.
- Give records stable permalinks.
- Import data over ODBC from an existing database.
- Annotate text semi-automatically.
- Meet long-term preservation and documentation standards.
- Enable core Search before installing WissKI.
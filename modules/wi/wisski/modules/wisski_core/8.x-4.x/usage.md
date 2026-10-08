<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Core supplies the entity type, routing and user interface the rest of the WissKI set is built on. It is required.

---

Everything else in WissKI attaches to this. It defines the WissKI individual entity — the record a researcher edits, whose data actually lives in a triple store — plus the routes that display and edit it, the query factory that turns Drupal entity queries into store queries, the namespace manager, and the title and forwarding machinery.

The design point worth understanding is that a WissKI entity is a Drupal entity whose storage is not Drupal's. `entity.query.wisski_core` is built from the pathbuilder manager and the SALZ query annotator and planner, which means a query written against the entity API is translated into SPARQL against whatever adapter is configured. That is what lets the rest of Drupal — Views, forms, field displays — work against semantic data without knowing it is semantic.

**This module is why WissKI cannot be enabled without core's Search module.** `wisski_core.services.yml` injects `@search.search_page_repository` into `wisski.route_subscriber`, while `wisski_core.info.yml` declares only `inline_entity_form`, `wisski_autocomplete`, `wisski_pathbuilder` and `wisski_salz`. **Verified:** enabling it produced *"The service `wisski.route_subscriber` has a dependency on a non-existent service `search.search_page_repository`"* on every request and in Drush, so the site could not be repaired with Drush and needed a direct `core.extension` edit. Enable core `search` first. This documentation is written from source for that reason.

---

- Define the WissKI entity type.
- Edit a record whose data lives in a triple store.
- Query WissKI entities through the entity API.
- Translate an entity query into SPARQL.
- Route WissKI entity display and edit pages.
- Manage RDF namespaces.
- Generate entity titles from paths.
- Forward a URI to its entity view.
- Build Views over semantic data.
- Use standard field displays on WissKI entities.
- Enable core Search before installing WissKI.
- Diagnose the route subscriber service error.
- Recover a site broken by enabling WissKI.
- Understand the SALZ query pipeline.
- Extend WissKI with a custom entity behaviour.

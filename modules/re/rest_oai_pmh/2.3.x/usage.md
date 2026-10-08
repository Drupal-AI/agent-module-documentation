<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST OAI-PMH turns a Drupal site into a standards-compliant **OAI-PMH 2.0 repository**, letting metadata harvesters (aggregators, digital-library catalogs, discovery systems) pull your content as Dublin Core, MODS, or a custom XML schema. You pick which Views feed the endpoint; the module indexes their results and answers the six OAI verbs at `/oai/request`.

---

The module exposes a single REST resource (`oai_pmh`) at `/oai/request` (path configurable) that speaks the OAI-PMH 2.0 protocol: `Identify`, `ListMetadataFormats`, `ListSets`, `ListIdentifiers`, `ListRecords`, and `GetRecord`, all driven by a `verb` GET/POST parameter. Rather than exposing entities directly, you select one or more **Views** (each must have an *Entity Reference* display) on the settings form (`/admin/config/services/rest/oai-pmh`); a queue/batch/cron job then materializes those View results into three index tables (`rest_oai_pmh_record`, `rest_oai_pmh_set`, `rest_oai_pmh_member`). Each selected View becomes an OAI **set**, unless its display has an entity-reference contextual filter, in which case each referenced entity (e.g. a collection term) becomes a set. At harvest time each record is rendered by a configurable **OaiMetadataMap** plugin — Dublin Core from RDF/schema.org mappings, Dublin Core from Metatag, MODS from a View, or raw fields for testing. Entity and field **access is re-checked live** as the requesting (usually anonymous) user, so unpublished or unprivileged content indexed from a View is filtered out of responses. Enabling the module installs the REST resource but it stays `403` until you grant the `restful get oai_pmh` permission (normally to the anonymous role). Index freshness is handled by a pluggable **OaiCache** strategy — *liberal* (rebuild automatically on any relevant entity save) or *conservative* (only drop deleted entities; rebuild via cron or the manual **Rebuild** form). Large result sets are paged with OAI **resumptionToken**s stored in a keyvalue store with a configurable expiry.

---

- Publish a library or archive's catalog records for harvesting by aggregators such as OCLC, DPLA-style hubs, or BASE.
- Expose a Drupal-based institutional repository so its metadata can be indexed by union catalogs.
- Serve Dublin Core (`oai_dc`) metadata for a curated View of published articles or documents.
- Provide MODS metadata for bibliographic records via a dedicated MODS View mapping.
- Feed a discovery layer (e.g. Primo, VuFind) with periodically harvested metadata instead of a live API.
- Organize harvestable content into OAI **sets**, one per curated View (e.g. "Journals", "Photographs", "Theses").
- Derive sets dynamically from an entity-reference contextual filter so each collection/term becomes its own set.
- Let harvesters do incremental updates using `from`/`until` datestamp parameters against the record's `changed` time.
- Support selective harvesting of a single set via the `set` parameter on `ListRecords`/`ListIdentifiers`.
- Return a single record on demand with `GetRecord` and an `oai:host:type-id` identifier.
- Advertise which metadata formats the repository supports via `ListMetadataFormats`.
- Page through large harvests safely using `resumptionToken`s with a configurable expiry window.
- Keep the endpoint's index automatically fresh with the *liberal* cache strategy so edits appear without manual work.
- Use the *conservative* cache strategy on high-write sites and rebuild the index on cron or on demand.
- Rebuild the OAI index manually after bulk imports via the **Rebuild** admin form (`/admin/config/services/rest/oai-pmh/queue`).
- Change the repository's public path from `/oai/request` to a custom URL to match an existing harvester configuration.
- Set the advertised repository name and admin e-mail returned by the `Identify` verb.
- Add a **custom metadata schema** (e.g. MARCXML, MODS variant, ETD-MS) by writing an `OaiMetadataMap` plugin with its own Twig template.
- Override an existing metadata plugin's Twig template from your own module via `hook_rest_oai_pmh_metadata_template_alter()`.
- Restrict the repository to only the content a Views access filter and entity access allow anonymous harvesters to see.
- Combine several Views into one repository, each contributing its own set of records.
- Expose non-node entities (media, taxonomy terms, custom entities) by pointing a View's Entity Reference display at them.
- Migrate an existing OAI-PMH provider onto Drupal while keeping the same base URL and set structure for downstream harvesters.
- Integrate with `dgi_image_discovery` to resolve thumbnail URLs in RDF-based Dublin Core output.
- Validate your metadata output against OAI-PMH validators by pointing them at `/oai/request?verb=Identify`.

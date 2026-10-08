DCAT-AP extends the base dcat module with the DCAT-AP 2.1.0 application profile by adding profile-specific fields and mandatory/recommended constraints to the existing DCAT dataset, distribution and agent entities.

---

The module ships no entity types, routes, permissions, services or admin UI of its own. It plugs into the base dcat module's `dcat_field_provider` plugin system with three provider plugins — `DcatApDatasetFields`, `DcatApDistributionFields` and `DcatApAgentFields` (all plugin weight 5) — whose `getFieldDefinitions()` contribute extra DCAT-AP base fields and whose `alterFieldDefinitions()` tighten the base fields to match the profile. New dataset fields cover owl:versionInfo, dcterms:isVersionOf, dcat:hasVersion, dcterms:source, dcterms:provenance and adms:sample; new distribution fields cover spdx:checksum and adms:representationTechnique; the agent plugin adds no new fields. Mandatory DCAT-AP properties are marked required (dataset description and publisher, distribution title and access URL, agent name), and recommended fields (theme, format, media type, status, agent type) get descriptions pointing at the EU controlled vocabularies. Because the base dcat module creates the entity tables before dcat_ap is enabled, `hook_install()` calls dcat's `dcat_sync_entity_schemas()` so the new and altered fields are written to the database. Optional entity form/view display config under config/optional/ positions the new fields on the default displays, and is applied only when the base displays plus the core link and text modules are present.

---

- Publish an open-data catalog in Drupal that conforms to the DCAT-AP 2.1.0 profile rather than plain DCAT.
- Add a machine-readable version indicator (owl:versionInfo) to datasets, e.g. "1.0.2".
- Record dataset lineage across editions with "Is Version Of" (dcterms:isVersionOf) and "Has Version" (dcat:hasVersion) links.
- Capture the upstream dataset a dataset is derived from with the "Source" (dcterms:source) field.
- Document custody/ownership changes over a dataset's lifetime in a free-text "Provenance" (dcterms:provenance) field.
- Reference one or more sample distributions of a dataset via "Sample Distribution" (adms:sample), an entity reference to dcat_distribution.
- Store a distribution integrity checksum (spdx:checksum) in "algorithm:hash-value" form, e.g. "sha-256:9f86d08...".
- Declare how a distribution is encoded with a "Representation Technique" (adms:representationTechnique) URI from the EU vocabulary.
- Enforce that every dataset has a description and a publisher before it can be saved, as DCAT-AP requires.
- Enforce that every distribution has a title and an access URL.
- Enforce that every DCAT agent (publisher/creator/etc.) has a name.
- Guide editors toward the EU Data Theme vocabulary for dataset themes via the updated field description.
- Guide editors toward the EU file-type and IANA media-type vocabularies for distribution format and media type.
- Guide editors toward the ADMS status vocabulary for distribution status.
- Guide editors toward the EU Corporate Body vocabulary for agent type (which becomes a taxonomy reference to the eu_corporate_body vocabulary).
- Keep the base dcat entity tables in sync with the profile's added fields automatically at install time.
- Layer DCAT-AP compliance onto an existing dcat catalog without migrating or recreating any content entities.
- Configure the new fields' widgets and formatters per display through the standard Manage form/display and Manage display screens.
- Add or remove DCAT-AP support cleanly by enabling/disabling the module alongside the base dcat module.
- Serve as a worked example of building on top of the base dcat `dcat_field_provider` plugin type from a separate contrib module.
- Prepare dataset metadata for downstream RDF export (via the base project's dcat_export submodule) in a DCAT-AP compliant shape.

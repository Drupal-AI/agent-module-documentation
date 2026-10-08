<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Directories: Open Referral maps directory facets onto Open Referral taxonomy, so a LocalGov directory can be published as machine-readable Open Referral data for aggregators and partner services. Experimental.

---

Open Referral is a data standard for community service directories, and the `localgov_openreferral` module publishes LocalGov content in that format. The gap it cannot fill on its own is *taxonomy*: LocalGov Directories stores its categories as `localgov_directories_facets` content entities, which Open Referral knows nothing about. This submodule closes that gap with a `FacetMapping` service that synchronises facet definitions into Open Referral property mappings. The synchronisation is event-driven: `hook_node_insert()`, `hook_node_update()` and `hook_node_delete()` watch for changes to `localgov_directory` **channel** nodes and re-run `synchroniseFacetMappings()` each time, because which facets are relevant depends on which facet types a channel has enabled. On update the node storage cache is reset first so the mapping sees the saved state. The module is marked *LocalGov Drupal (Experimental)* in its package and ships no UI, permissions, schema or Drush commands — it is glue between two other modules.

---

- Publish a council directory as Open Referral data.
- Let a regional aggregator consume local service listings.
- Map directory facets onto Open Referral taxonomy terms.
- Keep facet mappings in sync as channels change.
- Share family services data between neighbouring authorities.
- Provide machine-readable categories alongside human-readable facets.
- Support a partner app that reads Open Referral feeds.
- Avoid hand-maintaining a parallel taxonomy for data exchange.
- Feed a national directory aggregation project.
- Publish community-sector data in a recognised standard.
- Let facets remain editor-managed while still being exportable.
- Re-synchronise mappings automatically when a channel is created.
- Remove mappings cleanly when a channel is deleted.
- Prototype Open Referral publishing before committing to it.
- Combine with the venue Open Referral submodule for full service records.
- Reduce integration effort for third-party directory consumers.
- Keep the Drupal-side model unchanged while exposing a standard one.
- Support open data commitments for local government.
- Give service finders a consistent category vocabulary.
- Enable cross-authority reporting on service categories.

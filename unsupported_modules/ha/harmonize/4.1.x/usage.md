<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Harmonize is a developer framework that preprocesses entity content into a consistent, cleanly-structured `harmony` variable available in Twig templates.
---
Once preprocessing is enabled on an entity-type bundle (a "Harmonize settings" section is added to bundle edit forms, and a "Manage preprocessing" tab controls which fields are processed), Harmonize builds a normalised `harmony` array via a set of per-entity Harmonizer classes (node, media, file, paragraph, taxonomy term, menu link, image style, etc.), a master harmonizer factory, and an event system (`EntityHarmonizationEvent`, `EntityFieldHarmonizationEvent`, form/menu/region events) so modules can alter the output. It adds a Twig extension for accessing harmonized data, a `Style` config entity for reusable field-render styles, an "Entity Processing Rules" admin UI, a dedicated cache bin (`cache.harmonize`), and a Visualizer. Submodules provide extras (harmony file discovery, SDC display, refinery, examples).

All admin surfaces — settings, entity rules add/edit/delete, cache config, visualizer, and the entity-fields autocomplete controller — are gated by the core `administer site configuration` permission; a custom access checker (`_manage_preprocessing_access_check`) governs the Manage preprocessing tab. There are no anonymous, mutating, or public endpoints. Note the module's README states it is nearing end-of-life (superseded by "Glint") and warns of performance overhead if overused. No security findings.
---
- Enable preprocessing on a content type bundle.
- Access a clean `harmony` data array in Twig templates.
- Read nested entity/field values without deep Drupal render arrays.
- Choose which fields are harmonized via Manage preprocessing.
- Define reusable render Styles for fields.
- Add Entity Processing Rules per entity type or bundle.
- Use the Harmonize Twig functions/filters.
- Alter harmonized output via harmonization events.
- Cache harmonized data in the dedicated `cache.harmonize` bin.
- Visualize harmonized entity structure with the Visualizer.
- Autocomplete entity fields when configuring Styles.
- Harmonize media, files, paragraphs and taxonomy terms consistently.
- Use the harmony file-discovery submodule.
- Render harmonized data through Single Directory Components (SDC submodule).
- Share a consistent data shape between backend and frontend teams.
- Call the `harmonize` service directly from custom code.
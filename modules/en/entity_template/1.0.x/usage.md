<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Store reusable templates of entities and create new pre-filled entities from them through a builder flow.

---

Entity Template lets you define reusable "templates" for entities: a template is a list of component plugins that populate a target entity's fields, where each value can be a static input or a tokenised/Twig string resolved from typed-data contexts and builder parameters. Templates are grouped into blueprints, blueprints belong to a builder, and a multi-step build flow (collect parameters, select a blueprint, then a normal entity edit form pre-filled from the template) produces the new entity. The optional Entity Template UI submodule adds the admin interface for defining builders, blueprints, templates and components. The system is plugin-based (builder, template, component and blueprint-provider plugin types) so developers can extend every stage, and it depends on the contributed Typed Data module for its placeholder/filter engine. Supports Drupal 9.1, 10 and 11.

---

- Stamp out many similar entities (nodes, media, custom entities) from a shared template instead of copying by hand.
- Pre-fill a new node's fields from a saved template before the editor finishes it.
- Build a "new campaign", "new event" or "new product" wizard that collects a few parameters and creates a consistently shaped entity.
- Populate a field with a tokenised string like a title assembled from parameter values.
- Render long/formatted text fields (body, summary) from a Twig template so optional paragraphs appear only when their data is present.
- Use typed-data filters (format_field, format_date, option_label, entity_url and more) inside placeholders and Twig to format field values.
- Create related entities together by nesting an inline template on an entity_reference field.
- Offer editors a choice of several blueprints for the same content type and let them pick the closest starting point.
- Auto-select the single available blueprint and skip the selection step when only one applies.
- Apply conditions so a template only applies in certain situations.
- Pass entity parameters (e.g. a referenced user or node) into a build and read their fields via placeholders.
- Prioritise competing templates/blueprints so the best match wins.
- Provide default field values for a bundle from a builder's default blueprint.
- Extend the module with a custom component plugin that sets a field in a bespoke way.
- Extend the module with a custom builder or blueprint provider plugin to source templates from somewhere other than config.
- Store templates as configuration entities so they travel through the normal config export/import workflow.
- Seed content during site building by running a builder to generate starter entities.
- Combine static defaults with dynamic, parameter-driven values in one template.
- Format dates in generated values with date add/subtract filters for relative deadlines.
- Turn option/list field keys into their human labels inside generated text.
- Generate an entity whose bundle is inferred from the target field's reference settings.
- Give content teams a repeatable, guided way to create structured content without manual field-by-field entry.
- Reuse the same blueprint across multiple builders that target the same entity type.
- Provide a starting entity form URL from a builder's default blueprint for quick content creation.

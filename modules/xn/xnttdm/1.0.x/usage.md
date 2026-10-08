<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
External Entities Data Model Aggregator (xnttdm) adds a "model" data aggregator to the External Entities module so several content-entity storage groups can act as data inputs or outputs for transfer or conversion.

---

xnttdm plugs into External Entities (`external_entities` >= 3.0) and registers a `model` DataAggregator plugin (extending the core GroupAggregator), a `content` storage client (ContentEntityClient) and a `ModelPropertyMapper`. An external entity type configured with the Model data aggregator is composed of several "model elements" — each backed by a Drupal content entity type/bundle — plus an ID mapper that associates IDs across those elements. "Model aggregations" define, per configuration, which model elements are read (loaded from) and which are written (saved to), with asymmetric read/write sets and per-field mappings, so one external entity type can aggregate, replace or convert selected fields from one content storage group into another.

The module is entirely configuration-driven through the External Entities type form: it exposes no routes, no permissions and no HTTP endpoints of its own. Its only runtime hook is `hook_entity_presave` (via `XnttdmHooks`), which cleans up field-mapper "locks" it added when an external entity type stops using the model aggregator. It makes no external network calls and stores no credentials. Typical setup: create an external entity type, choose the "Model data aggregator", add model elements (content types), define an ID association and one or more model aggregations, then map fields between the read and write model elements. A config schema is provided at `config/schema/external_entities.data_aggregator.schema.yml`.

---
- Install alongside External Entities 3.x to enable data-model aggregation.
- Create an external entity type that uses the "Model data aggregator".
- Add several model elements, each backed by a content entity type/bundle.
- Configure the ID mapper storage client to associate IDs across model elements.
- Define an ID association model aggregation to set the reference identifier.
- Add additional model aggregations describing read vs write model element sets.
- Choose which model elements are used for loading (reading) data.
- Choose which model elements are used for saving (writing) data.
- Map an external entity field to a source field of a specific model element.
- Convert a field value from one content type into a field of another content type.
- Aggregate (merge) data from multiple content types into one external entity.
- Replace data in a target storage group with data read from another.
- Switch the active model aggregation to change the load/save behaviour.
- Set per-field property mappings using the xnttdmmulti property multi-mapper.
- Add administrative notes/descriptions to each model aggregation.
- Remove a model aggregation you no longer need.
- Reorder the ID mapper relative to other storage clients per aggregation mode.
- Rely on hook_entity_presave to clean up field-mapper locks when switching aggregators.
- Use the provided config schema to validate the aggregator configuration.
- Build data-migration/conversion pipelines between Drupal content types without custom code.

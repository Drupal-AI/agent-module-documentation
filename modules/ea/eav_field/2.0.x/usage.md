<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EAV Field provides an Entity-Attribute-Value field type so a host entity can carry an open-ended, admin-defined set of attributes without adding a Drupal field per attribute.
---
Instead of modelling every property as its own field, you define **EAV Attributes** (a `eav_attribute` config-like content entity) once, then attach a single `eav` field to any bundle. Each attribute declares its own value field type (string, text, integer, boolean, options, …), widget and formatter, and its values are written to a dedicated `eav_value` content entity, keyed back to the host entity. Attributes can be scoped globally or by a taxonomy **category**, and the module matches attributes to a host entity by comparing the host's entity-reference field to the attribute's category (including parent terms). This suits catalogues, product specs, or any content where the attribute set varies by item and is maintained by editors, not developers.

Operationally: enable the module, create attributes under *Structure > EAV > Attributes*, configure each attribute's value storage/field/widget/formatter, then add the *EAV* field to a bundle and edit values through the host entity form or the dedicated `/{entity}/edit-eav/{field_name}` tab. All admin routes are gated by the `administer eav attributes` permission; the per-entity EAV edit tab is gated by that entity type's `update` access. Storage uses Drupal's entity/field query API and SqlContentEntityStorage throughout (no raw SQL), with a QueueWorker for deferred cleanup of orphaned value entities and an optional Search API processor to index EAV values.
---
- Attach one EAV field to a bundle to hold many dynamic attributes
- Define reusable attributes under Structure > EAV > Attributes
- Choose a value field type per attribute (string, text, integer, boolean, options)
- Configure the widget used to edit each attribute's value
- Configure the formatter used to display each attribute's value
- Scope attributes globally so they apply to all matching hosts
- Scope attributes to a taxonomy category
- Inherit attributes from parent taxonomy terms of the category
- Match attributes to a host via its entity-reference (category) field
- Edit attribute values on the host entity form
- Edit attribute values on the dedicated edit-eav local task tab
- Reorder attributes with the weight sort
- Delete an attribute and queue cleanup of its value entities
- Index EAV values for search via the Search API processor
- Generate sample attributes with the Devel Generate plugin
- Render an attribute list with the eav-list template
- Build product-spec sheets where specs vary by product type
- Store per-category custom fields without per-bundle field bloat
- Model classified-ad style attributes that differ per listing
- Provide editors a UI to add new attributes without code
- Load attributes programmatically by category or host entity
- Use unlimited-cardinality value loading to fetch all values
- Theme the EAV output with theme suggestions per field/attribute
- Keep host entity forms lean by delegating variable fields to EAV
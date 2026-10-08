<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `entity_segment` plugin type + `field_value`

A segment condition is an `EntitySegment` plugin: a single configurable predicate that selects entities of the segment's **target** type. Segments compose these into an AND/OR tree.

## Plugin type

- Attribute `#[EntitySegment]` (`src/Attribute/EntitySegment.php`): `id`, `label`, `description`, `target_entity_types` (array; **empty = applies to any content entity type**, a non-empty list restricts to those targets, e.g. `['crm_contact']`), `deriver`.
- Namespace `Plugin/EntitySegment`. Manager `SegmentPluginManager` (`plugin.manager.entity_segment`, alter hook `entity_segment_info`, cache key `entity_segment_plugins`). `getDefinitionsForTarget($target)` filters by `target_entity_types`.
- Interface `SegmentPluginInterface` (extends `PluginInspectionInterface`, `ConfigurableInterface`, `PluginFormInterface`):
  - `setTargetEntityTypeId()` / `getTargetEntityTypeId()` — the segment's target type is injected as context **before** any form build / resolve.
  - `resolveToIds()` — universal fallback; every plugin returns the target IDs it matches.
  - `summary()` / `summaryParts()` — human-readable description (parts: `field`/`operator`/`value` or a single `summary`).
- `QueryableSegmentPluginInterface` (opt-in): adds `applyToQuery(ConditionInterface $condition)`. A plugin implementing it can be folded into a single entity query; it MUST still implement `resolveToIds()`, and the two paths must select identically. Detected by the resolver with `instanceof`.
- `SegmentPluginBase` supplies config handling, the target-type accessors, no-op validate/submit, and a default single-part `summaryParts()`.
- **Negation convention**: the tree grammar has NO `NOT`; a plugin owns inversion via its own operators (e.g. `is` / `is not`).

## `field_value` (shipped)

`Plugin/EntitySegment/FieldValue` — the generic reference plugin, `implements QueryableSegmentPluginInterface`. Selects entities where a field has a given value; every field path is rooted at `rootType()` (the target type, else `LogicException`).

- Config: `field_name` (entity-query field path), `operator`, `value` (always stored as an array of scalars, one/two/many/none per arity). `hop` is form-only and stripped in `submitConfigurationForm()`.
- Field discovery (`getFieldOptions()`): unions non-computed, non-reference fields across the target type's bundles. A field with a main property is offered bare; a compound field is expanded to one option per stored column (`field.property`), the exact path the entity query resolves. References are offered only as descend hops, never leaves.
- Multi-hop traversal: the cascade selector appends `<reference>.entity` hops to any depth (`buildConfigurationForm()`, `placeHopSelect()`, `hopFieldOptions()`, `assembledPath()`, `explodePath()`), delegating all path walking to `property_traversal.fetcher`.
- Operators (`CATEGORY_OPERATORS`) depend on the leaf's data-type **category**, which `OperatorCategoryResolver` (`entity_segment.operator_category_resolver`) derives from the leaf field's **Views filter handler** (`views_data`). Arity map `OPERATOR_ARITY` (single/many/pair/none). Value input `#type` is `number` for the numeric category, else `textfield`.
- `applyToQuery()` is the **only** place values are shaped per arity and handed to `condition($path, $value, $operator)` (parameterized entity-query conditions — not raw SQL). `resolveToIds()` runs the same condition group through `accessCheck(FALSE)` (audience is the resolver's job, access the caller's).
- Validation (`validateConfiguration()`, also used by the entity constraint): field resolves to a queryable leaf, operator fits the category, value arity matches, numeric category gets numeric values.

## Read-only rendering

`ConditionTreeRenderer` (`entity_segment.condition_tree_renderer`) walks a stored tree, primes each plugin's target type, reads `summaryParts()`, and themes it via `entity_segment_conditions` (`templates/entity-segment-conditions.html.twig` — Twig auto-escapes every part). Fault-tolerant: a missing plugin or malformed node renders a stable line.

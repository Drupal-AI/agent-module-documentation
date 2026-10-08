<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Field Lookup is a Migrate API process plugin (`plugin: entity_field_lookup`) that finds an existing entity by running an entity field query — matching a field's value rather than looking up an id from another migration's map — and returns the matched entity id.

---

Resolving references is the hard part of most migrations, and core's `migration_lookup` only solves one shape of it: it finds an entity by the id **another migration** created, which works when you control both sides and fails otherwise — and "otherwise" is common. Content is imported against terms a site builder made by hand; a spreadsheet identifies people by email address; a feed names categories by label; a second import must attach to entities an earlier one made but whose ids nobody recorded. In each case the source names the target by **something other than its id**, and the migration must look it up by that value. This plugin does exactly that: it takes the incoming `source` value, builds an `EntityQuery` on the configured `entity_type_id`, constrains it to a bundle (`bundle_key`/`bundle_id`, which may be an array of bundles matched with `IN`), and adds `condition(entity_field, value)` — plus any number of `extra_conditions` (each with its own `field`, `value`, `operator`, and `langcode`). It runs the query and returns the **first** result id via `reset()`, or `NULL` when nothing matches or when the input value is `NULL`. The four keys `entity_type_id`, `bundle_key`, `bundle_id`, and `entity_field` are mandatory — a missing one throws `BadPluginDefinitionException` at construct time; an unknown entity type or an `extra_conditions` entry without a `field` throws `InvalidPluginDefinitionException`. Access checking is on by default: the query calls `->accessCheck(TRUE)` unless you explicitly set `access_check: false`. Three things decide whether the lookups are reliable, and they produce quietly wrong data rather than errors. **The queried field must be unique in practice** — two people sharing a surname, two terms with the same name in different vocabularies, two products sharing a code — because returning the first match silently attaches content to the wrong entity, far worse than failing. **A miss needs a defined outcome**: the plugin returns `NULL`, so pair it with `skip_on_empty`, a default value, or a stub-creating migration depending on what the case demands. And **a query runs per row**, so on a large migration the lookup is often the slowest step — worth measuring and worth indexing the field being queried.

---

- Look up a taxonomy term by its name during a content migration.
- Find a user by email address to set an author reference.
- Resolve an entity reference by an external / legacy code.
- Attach imported content to hand-created taxonomy terms.
- Look up a commerce product by SKU.
- Resolve a category by its label from a feed.
- Find an entity when there is no migration map to look up against.
- Import a second dataset that must attach to entities an earlier migration created.
- Look up a node by a legacy identifier stored in a field.
- Attach media to content by matching a filename field.
- Resolve an organisation by a registration-number field.
- Constrain a lookup to several bundles at once by passing `bundle_id` as an array.
- Narrow a lookup with `extra_conditions` (e.g. a numeric field `>=` a threshold, filtered by `langcode`).
- Resolve a reference by a business key composed of one primary field plus extra conditions.
- Return `NULL` on no match and drive `skip_on_empty` from it.
- Bypass entity access with `access_check: false` for a fully trusted, complete import.
- Keep entity access on (the default) so unpublished/inaccessible entities are excluded from matches.
- Look up an author entity by a name field.
- Resolve a location by a postcode field.
- Chain the returned id into an entity-reference destination field.

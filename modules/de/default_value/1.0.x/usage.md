Default Value applies a field's configured default value to already-existing content entities when they are loaded, filling fields that were saved empty.

---

Drupal's built-in field defaults only take effect when a brand-new entity is created; entities saved before a field or its default existed keep their empty values. The Default Value module closes that gap. An administrator visits its settings form (`/admin/config/system/default-value`) and ticks the bundles of any content entity type that should be covered. From then on, `hook_entity_load()` inspects every loaded entity of an opted-in bundle: for each configurable field (a `FieldConfig` instance) whose value list is empty, it reads the field's default value literal and sets it on the entity in memory. Entity-reference defaults stored as `target_uuid`, and image field default images stored by `uuid`, are resolved to the local `target_id` before being applied. The change is applied only to the loaded object — the module never re-saves the entity, so this is a display/runtime fallback rather than a data migration. Saving the settings form truncates the entity, render, menu, page and dynamic-page caches so the new coverage takes effect immediately. The module has no dependencies beyond core, ships no config schema, and exposes a single permission gating its settings route.

---

- Backfill a newly added field's default onto thousands of pre-existing nodes without a batch update or re-save.
- Show a fallback taxonomy term, boolean, or string on legacy content that predates a field.
- Give empty entity-reference fields a configured default referenced entity on load.
- Apply a field's default image to existing content that never had one set.
- Populate a default value for a field added to an existing content type after content already existed.
- Provide a consistent placeholder value across an entire bundle without editing each entity.
- Ensure downstream code, Views, or templates always see a value for a field rather than an empty list.
- Opt in only specific bundles of a content entity type (e.g. only the "article" bundle of node).
- Cover custom content entity types as well as core ones (users, nodes, taxonomy terms, media, etc.).
- Avoid a data migration when you only need the default to appear, not to be persisted.
- Roll out a field default to old content and new content uniformly from one setting.
- Keep storage untouched while still presenting defaulted values, so the change is fully reversible.
- Temporarily supply values during a content model change, then disable the bundle when real data is entered.
- Default a required-in-display field so existing entities render without gaps.
- Standardise reference fields (e.g. a default "category") on legacy records.
- Present a default image for media or node image fields that older items lack.
- Exclude entity types that should never be defaulted (path_alias, file, contact_message, etc. are already excluded by the module).
- Flush relevant caches automatically when coverage changes, so results are visible right away.
- Gate who can change the coverage with the dedicated administration permission.
- Use as a lightweight alternative to writing a custom `hook_entity_load()` for the same purpose.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Convert Bundles changes existing content entities from one bundle (content type / vocabulary / media type / paragraph type …) to another, moving their data by mapping the source bundle's fields onto the target bundle's fields.

---

The module adds a Drupal **action** (`convert_bundles_action_base`) for every entity type that has two or more bundles, plus a per-entity **"Convert Bundle"** local task tab and a whole-bundle **config form** at `/admin/config/content/convert_bundles`. On install (and via `hook_entity_operation_alter`) it auto-creates one configured action per multi-bundle entity type, named `system.action.convert_bundles_on_<entity_type>` (e.g. `convert_bundles_on_node`). Conversion is driven by a multi-step wizard (`ConvertBundlesForm`): you pick the source entities/bundle, choose a target bundle, then map each source field to a compatible target field (or `remove`, or `append_to_body`), and the change runs in a Batch. Under the hood the helper class `Drupal\convert_bundles\ConvertBundles` rewrites the `bundle`/`type` column directly in the entity's base, data, and dedicated field tables, then reloads each entity, copies mapped field values onto the new fields, creates a new revision where the entity is revisionable, and saves. Field options in the mapping form are filtered by data-type compatibility (only fields whose main-property data type matches are offered as targets). A `hook_convert_bundle_alter($old_entity, &$new_entity)` fires just before each converted entity is saved so other modules can adjust the result. Because the actions are standard Drupal actions, the conversion also works from `/admin/content` bulk operations and with Views Bulk Operations (VBO) and Rules. There is no per-conversion stored configuration — the only persistent config the module owns is the set of action entities.

---

- Convert a single node from one content type to another using the "Convert Bundle" tab on the node.
- Bulk-convert selected nodes on `/admin/content` from bundle A to bundle B via the action dropdown.
- Convert every entity of one bundle to another in one pass from `/admin/config/content/convert_bundles`.
- Merge a deprecated content type into a replacement type while keeping the content.
- Map a source field (e.g. `field_subtitle`) onto a differently-named target field during conversion.
- Drop fields that do not exist on the target bundle by mapping them to `remove`.
- Preserve orphaned field data by mapping a source field to `append_to_body` so its value is appended to the body.
- Reclassify taxonomy terms from one vocabulary to another (any entity type with 2+ bundles is supported).
- Convert media items between media types when re-organising a media library.
- Change paragraph items from one paragraph type to another.
- Convert `block_content`, `commerce_payment`, `message`, or `webform_submission` entities between their bundles.
- Run bundle conversion from Views Bulk Operations because it is exposed as a standard action.
- Trigger conversion from Rules or any module that consumes core actions.
- Consolidate several near-duplicate content types into a single canonical type.
- Split content workflow by moving items into a "review" bundle then back to "published" bundle.
- Retain revision history: the module creates a new revision with a "Converted from X to Y" log message on revisionable entities.
- Copy an entity-reference value (including a `media` reference rendered as a `<drupal-media>` embed) into the body during conversion via `append_to_body`.
- Grant a role only the ability to convert a specific entity type with the dynamic `convert <entity_type> bundle` permission.
- Restrict access to bundle conversion entirely with the `administer convert_bundles` permission.
- Programmatically alter the converted entity (set a parent term, adjust a field) with `hook_convert_bundle_alter()`.
- Batch-convert large numbers of entities without a manual per-entity edit, using the Batch-backed action.
- Standardise date values when converting between `datetime` fields (the module reformats to `Y-m-d`).
- Migrate content into a new information architecture without writing a custom migration.
- Test a content-model refactor on a copy of a bundle before deleting the old type.

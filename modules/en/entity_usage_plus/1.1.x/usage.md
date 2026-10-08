Entity Usage Plus extends the Entity Usage module with a Views filter for unreferenced entities, a usage-tab operation link, and an option to show a target entity's child entities in its usage tab.

---

Entity Usage Plus is a small add-on to the contrib Entity Usage module (`drupal/entity_usage ~2.0`). It contributes three things grounded in its source: (1) a non-exposable Views filter, `entity_usage_plus_unreferenced` ("Limit to unreferenced entities"), added via `hook_views_data_alter()` to every entity type Entity Usage is configured to track, which restricts a view to entities whose id is `NOT IN` the `entity_usage.target_id` set — i.e. content nothing references; (2) an optional override of Entity Usage's per-entity "Usage" local-task tab, controlled by the boolean config `entity_usage_plus.settings:override_tab_display`, that swaps the tab controller for `LocalTaskUsagePlusController` so the table also lists the current entity's children (and grandchildren inside paragraphs / block_content) alongside its parents; and (3) special-casing of media so its row links to the media edit form. The override is applied by a `RouteSubscriber` that rewrites the `_controller` of each `entity.{type}.entity_usage` route (running at priority 98, after Entity Usage's own route subscriber) and requires a cache rebuild to take effect. Entity access is honored throughout: entity labels are shown only with `view label` access and links only with `view` (or media `edit`) access. The module adds no permissions of its own — the settings form is gated by Entity Usage's `administer entity usage` permission, and the usage tab keeps Entity Usage's access requirements. A typical use is auditing never-referenced media so it can be safely cleaned up. Note that Entity Usage counts references in previous revisions, so an entity referenced only in an old revision still counts as referenced.

---

- Build an admin view of media entities and add the "Limit to unreferenced entities" filter to find images/documents nothing links to, so they can be pruned.
- List orphaned nodes that are not embedded or linked anywhere according to Entity Usage.
- Audit unreferenced taxonomy terms, paragraphs, or any Entity-Usage-tracked entity type.
- Produce a cleanup report of unused content before a site migration or content freeze.
- Give editors a dashboard of "safe to delete" media to reclaim storage.
- Combine the unreferenced filter with other Views filters (bundle, author, created date) to scope the cleanup list.
- Feed an unreferenced-media view into a Views Bulk Operations workflow to delete or unpublish in bulk.
- Identify files uploaded but never placed in content.
- Turn on "Override entity usage tab display" to show, on each entity's Usage tab, the child entities it references (not just its parents).
- Inspect a node's Usage tab to see which paragraphs and block_content it embeds (grandchildren are flattened into the list with a "parent > field" label).
- Trace where a media item is used and jump straight to its edit form from the usage table.
- See parent, current, and child relationships for an entity in a single table with Relation / Entity / Type / Language / Field name / Status columns.
- Review the "Used in" column to tell whether a reference is in the default revision, a pending/draft revision, or an old revision.
- Confirm an entity is truly safe to delete by checking it has no parents in the usage tab before removal.
- Restrict what appears: entities the current user cannot view are shown as "- Restricted access -" rather than leaking labels or links.
- Add the settings link under the Entity Usage settings tabs (labelled "Entity Usage Plus") for administrators.
- Enable it after configuring Entity Usage tracking and running its bulk update so the unreferenced data is accurate.
- Use the unreferenced filter as a data-integrity check to catch content that fell out of use after edits.
- Support content governance by regularly surfacing stale, unreferenced assets.
- Document referential relationships for editors who need to understand where content is reused before changing it.

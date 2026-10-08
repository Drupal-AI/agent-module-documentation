<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Views Field adds a single Views field, **"Entity usage count"**, that renders how many times each row's entity is used elsewhere on the site, using data collected by the Entity Usage module.

---

The module is a thin Views integration on top of [Entity Usage](https://www.drupal.org/project/entity_usage). On `hook_views_data_alter()` it walks every entity type (optionally narrowed to the target types configured in `entity_usage.settings:track_enabled_target_entity_types`) that has a `views_data` handler and registers an `entity_usage_views_field` field on that entity's base Views table. The field is a `NumericField` handler that, per row, queries the `entity_usage` database table for records whose `target_id`/`target_type` match the row's entity, then loads the source entities and counts only usages recorded against each source's **default (current) revision** — so superseded draft references are not double-counted. Because that revision-awareness cannot be expressed as a SQL join on the primary Views query, the field is computed in PHP per row and is therefore **not sortable and not filterable**. The field can optionally be rendered as a modal link to the entity's Entity Usage report by rewriting it as a custom link (adds `use-ajax` / `data-dialog-type="modal"` attributes). A cache-tags invalidator rebuilds Views data whenever `entity_usage.settings` changes, so the field appears/disappears as tracked target types are reconfigured.

---

- Show an "in use" count column next to each Media item in a media library view so editors can spot unused files.
- List all nodes with a usage count to find orphaned content that nothing links to.
- Build a "safe to delete" report of taxonomy terms whose usage count is 0.
- Add a usage column to an admin content view so editors see how heavily each page is referenced.
- Surface how many pieces of content embed a given reusable block or paragraph.
- Give site owners a dashboard view of most-referenced entities (even though the column can't be sorted in SQL).
- Render the usage count as a clickable modal that opens the entity's Entity Usage report in a dialog.
- Audit reusable media before a cleanup migration by exporting a view with usage counts.
- Flag documents/files that are referenced nowhere so they can be archived.
- Combine with Views filters on other fields to review usage within a specific content type.
- Provide content strategists a quick "impact" number before unpublishing an entity.
- Track how many articles cite a particular reference or external link entity.
- Show usage counts in a Views REST export consumed by an external reporting tool.
- Add the count to a taxonomy term overview to see which categories are actually applied.
- Help moderators confirm an entity is unused before deleting it.
- Display reuse counts for shared components in a design-system content view.
- Restrict tracking to node and media in Entity Usage settings and expose the count only for those.
- Give a per-user "my most-used uploads" style view by combining the field with contextual filters.
- Report on reference-heavy entities that would be expensive to change.
- Include the usage number in an editorial "content health" view alongside last-updated dates.

Entity Editor Tabs relabels and reorders the primary local-task tabs (View / Edit / Layout / Latest version) and the entity operation links on content entities so the editorial workflow reads clearly when Layout Builder and/or Content Moderation are enabled.

---

The module has no UI, no config, and no permissions: it only implements `hook_local_tasks_alter()` and `hook_entity_operation_alter()` (dispatched to the `EetHooks` service). When Layout Builder overrides are enabled on a bundle it renames the core **Edit** tab's plugin class to show "Edit metadata" behaviour and retitles the **Layout** tab to "Edit content"; the entity operation links become "Edit metadata" and "Edit <singular label>" respectively. When Content Moderation moderates a bundle it swaps the **View** and **Latest version** tab classes (`EetCanonicalLocalTask` / `EetLatestLocalTask`) so the View tab shows the current published state (e.g. "View Published"/"View Draft") instead of a generic label. It also re-weights the View, Latest-version, Edit, Layout and Delete tabs so view-oriented and edit-oriented tabs group together, never modifying the canonical tab's weight. Bundle discovery uses the `entity_route_context` route helper to resolve each entity type's link templates to concrete route names and menu local-task IDs. `EetUtility::isLayoutBuilderOverridable()` checks the `entity_view_display` config for `third_party_settings.layout_builder.allow_custom = TRUE`. The module recommends the companion `layout_builder_operation_link` module for adding an Edit-to-Layout link from entity lists.

---

- Make the entity **View** tab display the current moderation state (e.g. "View Draft") when Content Moderation is on.
- Relabel the Layout Builder **Layout** tab to the clearer "Edit content".
- Relabel the core **Edit** tab to reflect that it edits metadata, not layout.
- Rename entity operation links to "Edit metadata" and "Edit content item" on Layout Builder bundles.
- Group the View and Edit tabs together in a logical order without hand-editing menu links.
- Keep the canonical (View) tab in its original position while re-weighting the others around it.
- Clarify editor UX on nodes that use both Content Moderation and Layout Builder overrides.
- Distinguish "edit the content" from "edit the layout" for content editors.
- Provide moderation-aware tab titles without writing a custom local-task plugin.
- Improve the entity operations dropdown on admin content lists for Layout-Builder-enabled bundles.
- Apply the same tab treatment across all content entity types (nodes, media, taxonomy terms, etc.).
- Avoid confusing editors when both a published and a draft (forward) revision exist.
- Surface the moderation state label directly in the tab rather than requiring a click.
- Ship editorial-friendly tab labels as code so they are consistent across environments.
- Reduce editor training overhead on sites combining moderation and Layout Builder.
- Pair with `layout_builder_operation_link` to jump straight to Layout Builder from content lists.
- Standardise entity-tab wording across a multi-content-type site.
- Give per-bundle behaviour automatically, driven by whether the bundle is moderated / LB-overridable.
- Keep tab reordering cache-correct (tabs add route cache context and entity cache tags).
- Adopt improved entity tabs with zero configuration after enabling the module.

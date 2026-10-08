<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Group Field lite lets editors attach or detach a content entity to Group entities from the entity's own edit form, using a per-group-type computed reference field and a simple select/checkbox widget.

---

Entity Group Field lite (`entitygroupfield_lite`) is a lightweight bridge between content entities and the Group module (drupal/group v3). For every group type on the site it exposes a read-only **computed** entity-reference base field named `group_<group_type_id>` on exactly the host entity types and bundles that a group relation plugin targets. You enable the field(s) you want on the host entity's **Manage form display** and assign the shipped **Group select list** widget (`group_select`). Editors then pick groups from a plain, no-AJAX select list right on the entity form; saving the entity creates or removes the matching Group relationship entities behind the scenes, so the module never stores its own field data. The widget collapses to a single on/off checkbox when only one group is selectable, lets you override the field label, supports multiple relationships, and marks options the current user cannot use as unavailable (via the Form Options Attributes dependency). It is a lighter alternative to the Entity Group Field module, and it is not intended for group relationships whose group-content carries its own fields that must be filled in when joining.

---

- Add a node to a group directly from the node edit form instead of the Group "Add content" workflow.
- Let users choose their group membership from their own account edit form.
- Expose a separate group field per group type when a site defines many group types.
- Attach a piece of content to two different group types at once using two distinct fields.
- Offer a single on/off checkbox to toggle membership of one unique group (e.g. a private section).
- Let editors move content between groups by changing the select value on the entity form.
- Detach content from a group by deselecting it on the entity form.
- Give the group field a friendlier, editor-facing label per form display.
- Provide a no-JavaScript, no-AJAX group picker for low-tech or accessibility-sensitive forms.
- Support selecting multiple groups when the relation's cardinality allows it.
- Show, on the view display, which groups an entity currently belongs to (read-only computed field).
- Reflect existing Group relationships automatically without a migration or data sync step.
- Build a "publish to community" UX where authors pick the target community group inline.
- Assign media items to groups from the media edit form.
- Let users self-select into interest or team groups on registration/profile forms.
- Attach commerce or catalog entities to store/section groups from their edit forms.
- Keep group assignment editing inside a single entity form rather than several Group screens.
- Restrict the pickable group list to a single group type via the field's target bundle.
- Replace a heavier Entity Group Field setup when group-content has no extra fields to set.
- Combine with Group's access rules so membership set here governs what members can see.
- Present group choices sorted alphabetically by group label (the field's default sort).
- Let content editors correct a wrong group assignment without admin help.
- Surface group assignment on custom content entity types provided by other modules.
- Drive membership for group types whose relation cardinality is unlimited or capped.

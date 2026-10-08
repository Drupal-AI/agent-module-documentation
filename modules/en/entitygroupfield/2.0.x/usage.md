Entity Group Field adds a computed "Groups" field to content (and users) that support Group relations, so editors can view and change which groups an entity belongs to directly from that entity's own add/edit form instead of the Group module's separate "add content" flow.

---

The module (which requires the `group` module, 2.x or 3.x) defines a computed base field named `entitygroupfield` and attaches it — via `hook_entity_base_field_info()` — to every entity type that has at least one Group relation plugin (e.g. `user` always has it through group memberships; nodes get it when a group-node relation is installed). The field is a computed `EntityReferenceItem` (`no_ui = TRUE`) whose value list is `EntityGroupFieldItemList`, targeting the site's group relationship entity (`group_relationship` on Group 3.x, `group_content` on Group 2.x). It ships two widgets — **Group select** (`entitygroupfield_select_widget`, the default) and **Group autocomplete** (`entitygroupfield_autocomplete_widget`) — with settings for label, help text, `multiple` and `required`; three formatters — `parent_group_label_formatter` (default), `parent_group_entity_formatter`, and `parent_group_id_formatter`; a `group_autocomplete` form element; and an `EntityGroupFieldSelection` entity-reference selection plugin. Because the field is added in the "hidden" region by default, you enable it per entity type by placing its widget on that entity's *Manage form display* (and, to show it, a formatter on *Manage display*). There is no admin settings page (`configure: null`); all configuration is per-bundle form/view display.

---

- Let editors set a node's groups from the node edit form instead of Group's separate "Add content" screen.
- Show a user's group memberships on their profile edit form.
- Add or remove group associations for content inline while editing it.
- Use the Group select widget to pick from a dropdown of allowed groups.
- Use the Group autocomplete widget for sites with many groups.
- Constrain the widget to a single group with the `multiple` = false setting.
- Require that content be placed in at least one group with the `required` widget setting.
- Provide editor guidance via the widget's help text setting.
- Display an entity's parent group as a label on its rendered page (`parent_group_label_formatter`).
- Render the full parent group entity in a view mode (`parent_group_entity_formatter`).
- Output just the parent group ID for theming or integrations (`parent_group_id_formatter`).
- Link the displayed parent group label to the group entity.
- Expose group assignment on media, taxonomy terms, or any entity type with a group relation.
- Streamline editorial workflows where every article must belong to a section group.
- Let site builders enable group editing per content type by configuring the form display.
- Keep group assignment consistent across Group 2.x and 3.x (the field resolves the right relationship entity).
- Use the `group_autocomplete` render element in custom forms to pick a group.
- Filter selectable groups via the EntityGroupFieldSelection entity-reference selection handler.
- Hide group editing on bundles that shouldn't have it by leaving the field in the hidden region.
- Surface a user's memberships in a profile view mode for display.
- Replace repetitive Group admin navigation with an in-context field on the entity form.
- Grant editors a simple way to move content between groups without Group admin permissions on every screen.

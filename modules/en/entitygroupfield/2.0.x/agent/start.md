# Entity Group Field — agent index

Adds a computed **`entitygroupfield`** ("Groups") field to every entity type that has a Group
relation, so editors set an entity's groups from its own add/edit form. Requires the `group`
module. No admin settings page (`configure: null`) — configure per bundle via *Manage form
display* / *Manage display*.

- **Enable the field on a bundle, widget & formatter settings, drush/config** →
  [configure/display.md](configure/display.md)
- **Field type, widgets, formatters, selection plugin, render element** →
  [plugins/field.md](plugins/field.md)

Key facts: the field is a computed base field (`no_ui=TRUE`), placed in the **hidden** region
by default; you show it by adding its widget to `core.entity_form_display.<entity>.<bundle>.<mode>`.
Widgets: `entitygroupfield_select_widget` (default), `entitygroupfield_autocomplete_widget`.
Formatters: `parent_group_label_formatter` (default), `parent_group_entity_formatter`,
`parent_group_id_formatter`. Target: `group_relationship` (Group 3.x) / `group_content` (2.x).

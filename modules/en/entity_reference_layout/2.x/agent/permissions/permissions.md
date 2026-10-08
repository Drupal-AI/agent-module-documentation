# ERL — permissions

Defined in `entity_reference_layout.permissions.yml`:

| Permission | Gates |
|---|---|
| `manage entity reference layout sections` | Whether the "Add Section" buttons appear in the ERL widget — i.e. adding/editing layout sections. Checked in `template_preprocess_entity_reference_layout_widget` via `$currentUser->hasPermission('manage entity reference layout sections')`. |

Not `restrict access: true`; grant to content-author roles that should be able to build
sections. Users without it can still edit paragraphs placed in existing sections but cannot add
new sections. The global settings form is separately gated by core `administer site
configuration`.

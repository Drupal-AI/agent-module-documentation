# views_bulk_edit — agent start

Adds a **"Modify field values"** bulk action to change field values on many entities of any
type at once. Ships two Action plugins: `views_bulk_edit` (a VBO action) and
`entity:edit_action` (a core Action derived per fieldable entity type, confirm form at
`/admin/content/bulk-edit`). Fields offered come from each bundle's **`bulk_edit`** form mode.
No hard module dependencies (info.yml declares none); VBO is a strongly-recommended companion
(`suggest`) for batching + "select all results". No central config UI.

- Add the action to a View + choose fields, change methods, revisions → [configure/views_bulk_edit.md](configure/views_bulk_edit.md)
- Control which fields are editable (bulk_edit form mode) & subclass the action → [extend/views_bulk_edit.md](extend/views_bulk_edit.md)
- The `use views bulk edit` permission → [permissions/views_bulk_edit.md](permissions/views_bulk_edit.md)

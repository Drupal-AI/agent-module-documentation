# layout_paragraphs_permissions — agent start

Submodule of **layout_paragraphs**. Adds granular permissions gating reorder, duplicate, and
layout-plugin-config actions in the drag-and-drop builder by overriding the parent's
`layout_paragraphs.builder_access` access check. Depends on `layout_paragraphs`. No settings
form. Grant at `/admin/people/permissions`.

- The three permissions and what they gate → [permissions/layout_paragraphs_permissions.md](permissions/layout_paragraphs_permissions.md)

Layout Paragraphs Permissions adds granular permissions that gate who may reorder (drag-and-drop), duplicate, and edit the layout plugin configuration of Layout Paragraphs components.

---

This submodule of Layout Paragraphs layers finer access control onto the drag-and-drop builder. Without it, any user who can edit a Layout Paragraphs field can perform every builder action; with it enabled, three new permissions become available to restrict specific operations per role. It defines `reorder layout paragraphs components` (drag/move/navigation), `duplicate layout paragraphs components` (the duplicate action), and `edit layout paragraphs plugin config` (access to the layout plugin configuration form when creating/editing a section). It works by overriding the parent module's `layout_paragraphs.builder_access` service with its own `LayoutParagraphsPermissionsBuilderAccess` access check (via `layout_paragraphs_permissions.services.yml`), which enforces these permissions on the builder's AJAX routes. It also ships a small library. There is no settings form — grant the permissions at **People → Permissions** (`/admin/people/permissions`). Enable it after `layout_paragraphs` when you need to give some roles building rights while withholding reorder/duplicate/plugin-config capabilities from others.

---

- Let some roles reorder components by drag-and-drop while others cannot.
- Withhold the duplicate action from lower-privileged editors.
- Restrict access to the layout plugin configuration form for sections.
- Give trusted editors full builder control and casual editors a limited set.
- Separate "content editing" from "layout manipulation" capabilities by role.
- Grant `reorder layout paragraphs components` to enable drag/move/navigation for a role.
- Grant `duplicate layout paragraphs components` to allow duplicating components.
- Grant `edit layout paragraphs plugin config` to allow configuring a section's layout plugin.
- Lock down structural changes on a content model while still allowing text edits.
- Enforce editorial governance over who can restructure layouts.
- Prevent accidental reordering by users who only need to update content.
- Apply least-privilege access to the Layout Paragraphs builder.
- Override the default builder access check with permission-aware logic (automatic on enable).
- Configure the permissions at /admin/people/permissions with no extra setup.
- Combine with the Library submodule so reuse and restructuring are governed separately.
- Enable per-role drag-and-drop control on multi-author sites.

# Permissions

From `paragraphs.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer paragraphs types` | Create/edit/delete Paragraphs types and their fields (the whole `entity.paragraphs_type.*` UI at `/admin/structure/paragraphs_type`). Admin/trusted only. |
| `administer paragraphs settings` | The global settings form at `/admin/config/content/paragraphs`. |
| `edit behavior plugin settings` | Editing a behavior plugin's per-paragraph settings inside the widget. |
| `view unpublished paragraphs` | Seeing unpublished paragraphs — only effective when the global `show_unpublished` setting is enabled (see [../configure/settings.md](../configure/settings.md)). |

Access is enforced by `ParagraphAccessControlHandler` and
`ParagraphsTypeAccessControlHandler`.

## Per-type CRUD permissions
The main module has no per-type create/edit/delete permissions — enable the
**paragraphs_type_permissions** submodule for those (documented separately). Library-related
permissions (`administer paragraphs library`, `create paragraph library item`,
`edit paragraph library item`) come from the **paragraphs_library** submodule, which hard-depends
on `entity_usage` and `views` and exposes a settings form at
`/admin/config/content/paragraphs_library_item` (route `paragraphs_library_item.settings`).

# Layout Paragraphs Permissions

Defined in `layout_paragraphs_permissions.permissions.yml`. Grant at **People → Permissions**
(`/admin/people/permissions`) or with `drush role:perm:add {role} '{permission}'`.

| Permission machine name | Gates |
|---|---|
| `reorder layout paragraphs components` | Drag-and-drop, move, and other navigation for Layout Paragraphs components (the builder's reorder action). |
| `duplicate layout paragraphs components` | Duplicating a Layout Paragraphs component. |
| `edit layout paragraphs plugin config` | Access to the "Layout plugin configuration" form when creating/editing a Layout (section). |

## How it is enforced

Enabling this submodule overrides the parent module's access service: its
`layout_paragraphs_permissions.services.yml` redefines the `layout_paragraphs.builder_access`
service to `Drupal\layout_paragraphs_permissions\Access\LayoutParagraphsPermissionsBuilderAccess`
(tagged `access_check`, `applies_to: _layout_paragraphs_builder_access`). That access check
applies the three permissions to the builder's AJAX routes (reorder, duplicate, edit) which are
guarded by `_layout_paragraphs_builder_access: 'TRUE'`.

Without this submodule, any user able to edit the Layout Paragraphs field can perform all
builder actions; installing it lets you withhold reorder/duplicate/plugin-config from specific
roles. There is no configuration form.

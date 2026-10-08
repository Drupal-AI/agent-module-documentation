<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# section_library — permissions

Defined in `section_library.permissions.yml`. Six permissions gate the template entity and
the import flow.

| Permission (machine name) | Gates |
|---|---|
| `import template from section library` | Use the "Choose template from library" picker and import a saved template into a layout (routes `section_library.choose_template_from_library`, `section_library.import_section_from_library`). |
| `view section library templates` | View saved templates; the access filter on the `views.view.section_library` listing. |
| `add section library templates` | Create new templates (save a section/page to the library via `AddSectionToLibraryForm`; `_entity_create_access: section_library_template`). |
| `edit section library templates` | Edit an existing template's label/image. |
| `delete section library templates` | Delete templates. |
| `administer section library template entities` | Full admin: the entity `admin_permission`, and the permission required by the settings form route `section_library.admin_index` (`/admin/config/content/section-library`). |

Enforced by `SectionLibraryTemplateAccessControlHandler` (view/edit/delete map to the
matching permissions above, with `administer …` as an override).

Grant with drush, e.g.:

```
drush role:perm:add content_editor 'add section library templates'
drush role:perm:add content_editor 'import template from section library'
drush role:perm:add content_editor 'view section library templates'
```

Typical split: give a design team `add`/`edit`/`delete`, give general editors only
`view` + `import`, and reserve `administer section library template entities` for admins.

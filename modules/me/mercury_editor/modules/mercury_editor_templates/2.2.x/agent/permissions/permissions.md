<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `mercury_editor_templates.permissions.yml` — seven permissions:

| Permission | Restricted | Gates |
|---|---|---|
| `administer mercury editor template` | yes | The settings/Field-UI route `entity.me_template.settings` (`/admin/structure/me-template`). |
| `access mercury editor template overview` | yes | The template overview/collection; also the entity's `admin_permission`. |
| `create mercury editor template` | no | Saving a section as a template (`save_as_template` route). |
| `view mercury editor template` | no | Viewing a template entity. |
| `edit mercury editor template` | no | Editing a template. |
| `delete mercury editor template` | no | Deleting a template (`delete mercury editor template`). |
| `use mercury editor templates` | no | **Key runtime permission**: makes published templates appear in the Mercury "add component" menu and allows the `insert_template` route. |

Notes:

- Access to the `me_template` entity is enforced by `MeTemplateAccessControlHandler`.
- The most important one for editors is **`use mercury editor templates`** — without it, the
  `LayoutParagraphsAllowedTypesEvent` subscriber returns early and no templates are offered in
  the builder, even if templates exist and are published.
- `create` gates the *Save as template* action; `use` gates *insert*. Grant both to editors who
  should build and reuse templates.

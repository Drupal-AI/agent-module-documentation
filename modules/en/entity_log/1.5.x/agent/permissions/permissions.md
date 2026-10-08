# Entity Log — permissions

From `entity_log.permissions.yml`:

| Permission | Gates | Restricted |
|---|---|---|
| `administer entity log entities` | The config form (`admin/config/entity-log`) and entity admin operations; the entity's `admin_permission`. | `restrict access: true` |
| `add entity log entities` | Create Entity Log entities. | no |
| `edit entity log entities` | Edit Entity Log entities. | no |
| `delete entity log entities` | Delete Entity Log entities. | no |
| `access entity log overview` | Access the `/admin/structure/entity_log` collection. | no |
| `view published entity log entities` | View published log entities. | no |
| `view unpublished entity log entities` | View unpublished log entities. | no |

Access is enforced by `EntityLogAccessControlHandler`. The configuration form itself is admin-only
(`administer entity log entities`, restricted). The view/add/edit/delete permissions gate the log entities as
normal content; grant the view permissions only to roles allowed to see recorded old/new field values.

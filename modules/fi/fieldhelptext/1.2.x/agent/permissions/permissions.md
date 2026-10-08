# Permissions

| Permission (title) | Machine name | Grants |
|---|---|---|
| Update field help text | `use fieldhelptext` | Access all three fieldhelptext routes, and thereby edit the description (and, on the by-field form, the label) of any configurable field on any fieldable entity/bundle. |

Defined in `fieldhelptext.permissions.yml`. This is the **only** access gate on the module —
every route (`fieldhelptext`, `fieldhelptext.bundle`, `fieldhelptext.field`) requires exactly
`_permission: 'use fieldhelptext'`.

Design intent: field descriptions and labels are field *configuration*, which core normally
lets you edit only with `administer <entity_type> fields` — a permission that also allows
adding, changing, and deleting fields (i.e. altering the data model). `use fieldhelptext`
carves out just the label/description editing, so a content designer or technical writer can
improve field guidance without being able to change the schema.

Grant it via drush:

```
drush role:perm:add content_editor 'use fieldhelptext'
```

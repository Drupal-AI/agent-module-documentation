# Field Report — permissions

The module defines a single permission in `field_report.permissions.yml`.

| Permission title | Machine name | Grants |
| --- | --- | --- |
| Administer Field Report | `administer field_report` | Access the Field Report page at `/admin/reports/fields/field-report`. |

- It is the only entry under `requirements` on route `field_report.fields_report`, whose
  `options._admin_route` is `TRUE`, so the report is reachable only by roles holding this
  permission (plus user 1).
- The permission is NOT flagged `restrict access: true`; it gates a read-only report of field
  *metadata* (labels, types, descriptions, bundle reuse). The Edit/Delete links inside the report
  are independently access-checked per field via `FieldConfig::access('update' | 'delete')`, so a
  user who holds this permission but lacks field-config edit rights sees the report without action
  links.

## Grant it

Drush:

```bash
drush role:perm:add editor 'administer field_report'
```

UI: `/admin/people/permissions` → "Field Report" section.

Role config (`user.role.editor.yml`):

```yaml
permissions:
  - 'administer field_report'
```

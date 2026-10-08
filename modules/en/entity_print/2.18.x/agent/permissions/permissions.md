# Permissions

Static (`entity_print.permissions.yml`) plus dynamically generated per-entity-type/bundle
permissions (`EntityPrintPermissions::getPermissions`).

| Permission | Gates |
|---|---|
| `bypass entity print access` | Access the printable version of **any** entity, ignoring the per-type checks below. Trusted. |
| `administer entity print` | The settings form and engine configuration. `restrict access: true`. |
| `entity print access type <entity_type_id>` | Use all print engines for that content entity type (e.g. `entity print access type node`). |
| `entity print access bundle <bundle>` | Use all print engines for a specific bundle (only generated when a type has >1 bundle). |

Access to a `print/…` route passes if the user has `bypass entity print access`, or the matching
type/bundle permission. Grant via drush:
```
drush role:perm:add authenticated 'entity print access type node'
```

The `entity_print_views` submodule adds its own `entity print views access` permission.

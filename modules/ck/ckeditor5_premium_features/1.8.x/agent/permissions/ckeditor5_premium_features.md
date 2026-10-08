# Permissions

Defined in `ckeditor5_premium_features.permissions.yml`.

| Permission | Gates |
|---|---|
| `use ckeditor5 access token` | Roles that use Cloud Services or on-premises server features such as real-time collaboration or export to Word/PDF. Controls access to the JWT token endpoint (`/ckeditor5-premium-features/token`, route `ckeditor5_premium_features.endpoint.jwt_token`). |
| `use ckeditor5 exporters endpoints` | Roles that use the export plugins (Word/PDF). Gates the exporter helper endpoints `/ck5/api/media-tags/{format}` and `/ck5/api/base64-image-converter`. |

The global settings form (`ckeditor5_premium_features.form.settings_general`) is instead gated by the core `administer site configuration` permission (see routing; a dedicated permission is noted as a TODO in source). The dependency-install route requires `administer modules`.

Grant the two permissions to authenticated editor roles that actually use the premium features:

```
drush role:perm:add editor 'use ckeditor5 access token'
drush role:perm:add editor 'use ckeditor5 exporters endpoints'
```

Individual submodules may define their own additional permissions (not documented here).

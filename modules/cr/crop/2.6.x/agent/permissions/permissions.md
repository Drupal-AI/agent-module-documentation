# Permissions

Defined in `crop.permissions.yml`:

- **administer crop** (`administer crop`) — Administer the basic settings for Crop API. This is
  the `admin_permission` of the `crop` content entity type (entity-granularity access).
- **administer crop types** (`administer crop types`) — Create, edit, delete and flush crop
  types. Gates the crop-type admin routes (`crop.overview_types`, `crop.type_add`,
  `entity.crop_type.edit_form`, `entity.crop_type.flush_form`).

Both are restricted admin permissions; grant only to trusted roles.

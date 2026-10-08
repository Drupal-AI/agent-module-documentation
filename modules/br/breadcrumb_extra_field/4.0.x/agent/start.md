# Breadcrumb Extra Field — agent index

Adds the site breadcrumb as a **display extra field** ("Breadcrumb") so you can position it
between fields on an entity's *Manage display*. Requires core `system` + `field`. No storage,
plugins, services, or Drush. Permission: `administer breadcrumb extra field`.

- **The two-step setup (enable bundles in settings → place the field on Manage display), the
  config key, and how rendering works** → [configure/settings.md](configure/settings.md)

Key facts:
- Config: `breadcrumb_extra_field.settings:breadcrumb_extra_field_admin` = nested map
  `entity_type → { bundle → bundle|0 }`. Settings form `breadcrumb_extra_field.settings` at
  `/admin/config/system/breadcrumb-extra-field`.
- `hook_entity_extra_field_info()` exposes a `display` extra field `breadcrumb` (hidden by
  default) on enabled bundles; `hook_entity_view()` renders it from the core `breadcrumb`
  service when the display has the `breadcrumb` component.
- After changing enabled bundles, invalidate cache tag `entity_field_info` (the form does this).

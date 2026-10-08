# jsonapi_extras — agent start

Adds configuration on top of core JSON:API: rename/disable resource types & fields, change
paths, and transform field values with **enhancer** plugins. Decorates
`jsonapi.resource_type.repository`. Depends on core `jsonapi`; uses the `e0ipso/shaper` library.
Config UI: **Admin → Config → Web services → JSON:API → JSON:API Extras**
(`/admin/config/services/jsonapi/extras`, route `jsonapi_extras.settings`).

- Global settings (path prefix, count, default-disabled) → [configure/settings.md](configure/settings.md)
- Override a resource: rename type/fields, change path, disable, add enhancers → [configure/resource-overrides.md](configure/resource-overrides.md)
- Field enhancer plugins (built-in list + write your own) → [plugins/field-enhancer.md](plugins/field-enhancer.md)
- Render an entity to JSON:API in PHP → [api/entity-to-jsonapi.md](api/entity-to-jsonapi.md)

Submodule `jsonapi_defaults` (default includes/filters/sorting) is documented separately.
